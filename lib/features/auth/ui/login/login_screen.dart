import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 80.h, right: 24.w, left: 24.w),
          child: Column(
            children: [
              SvgPicture.asset('assets/svgs/wallets.svg'),
              SizedBox(height: 16.h),
              Text('Welcome', style: TextStyles.blue20Bold),
              SizedBox(height: 8.h),
              Text('Login', style: TextStyles.gray16Medium),
              SizedBox(height: 40.h),
              FieldWidget(
                label: 'Phone',
                controller: TextEditingController(),
                hintText: '+966 50 123 4567',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.h),

              FieldWidget(
                label: 'Password',
                controller: TextEditingController(),
                hintText: '',
                isPassword: true,
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 8.h),

              Row(
                children: [
                  Spacer(),
                  Text('Forgot Password?', style: TextStyles.orange16SemiBold),
                ],
              ),
              SizedBox(height: 24.h),

              MyButton(
                text: 'Sign In',
                onPressed: () =>
                    context.pushReplacementNamed(Routes.homeScreen),
              ),
              SizedBox(height: 40.h),

              InkWell(
                onTap: () => context.pushNamed(Routes.registerScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont't have an account? ",
                      style: TextStyles.gray16Medium,
                    ),
                    Text('Sign Up', style: TextStyles.orange16SemiBold),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
