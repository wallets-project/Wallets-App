import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyles.black20SemiBold),
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorsManager.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up', style: TextStyles.black20SemiBold),
              SizedBox(height: 7.h),
              Text(
                'Create your wallet account',
                style: TextStyles.gray16Medium,
              ),
              SizedBox(height: 34.h),
              FieldWidget(
                label: 'Full Name',
                controller: TextEditingController(),
                hintText: 'John Doe',
                prefixIcon: Icons.person_outline_rounded,
              ),
              SizedBox(height: 15.h),

              FieldWidget(
                label: 'Phone',
                controller: TextEditingController(),
                hintText: '+966 50 123 4567',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15.h),

              FieldWidget(
                label: 'Email',
                controller: TextEditingController(),
                hintText: 'john@example.com',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15.h),

              FieldWidget(
                label: 'Password',
                controller: TextEditingController(),
                hintText: '••••••••',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 15.h),

              FieldWidget(
                label: 'Confirm Password',
                controller: TextEditingController(),
                hintText: '••••••••',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 44.h),
              MyButton(
                text: 'Sign Up',
                onPressed: () {
                  context.pushNamed(Routes.otpScreen);
                },
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyles.gray16Medium,
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(Routes.loginScreen);
                    },
                    child: Text('Sign In', style: TextStyles.orange16SemiBold),
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
