import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/otp_box.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinController = TextEditingController();
  final ValueNotifier<bool> isComplete = ValueNotifier<bool>(false);

  @override
  void dispose() {
    pinController.dispose();
    isComplete.dispose();
    super.dispose();
  }

  void _verify() {
    final String code = pinController.text.trim();
    debugPrint('Verifying OTP: $code');
    // TODO: call API
    context.pushNamed(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyles.blue20Bold),
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorsManager.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svgs/v4.svg'),
              SizedBox(height: 16.h),
              Text('Enter OTP', style: TextStyles.blue16Medium),
              SizedBox(height: 8.h),
              Text('OTP sent to your phone', style: TextStyles.gray16Medium),
              SizedBox(height: 8.h),
              Text('+966 50 123 4567', style: TextStyles.blue16Medium),
              SizedBox(height: 40.h),

              OtpBoxes(controller: pinController, isComplete: isComplete),

              SizedBox(height: 40.h),

              ValueListenableBuilder<bool>(
                valueListenable: isComplete,
                builder: (context, enabled, _) {
                  return MyButton(
                    text: 'Verify',
                    onPressed: enabled ? _verify : null,
                  );
                },
              ),

              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyles.gray16Medium,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Resend OTP',
                      style: TextStyles.orange16SemiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
