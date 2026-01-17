import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacementNamed(Routes.homeScreen);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('auth.login_success'.tr())));
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.primaryColor,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80.h, right: 24.w, left: 24.w),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svgs/wallets.svg'),
                    SizedBox(height: 16.h),
                    Text('auth.welcome'.tr(), style: TextStyles.blue20Bold),
                    SizedBox(height: 8.h),
                    Text('auth.login'.tr(), style: TextStyles.gray16Medium),
                    SizedBox(height: 40.h),
                    FieldWidget(
                      label: 'form.phone'.tr(),
                      controller: phoneController,
                      hintText: 'form.phone_hint'.tr(),
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 24.h),
                    FieldWidget(
                      label: 'form.password'.tr(),
                      controller: passwordController,
                      hintText: 'form.password_hint'.tr(),
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'auth.forgot_password'.tr(),
                          style: TextStyles.orange16SemiBold,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    MyButton(
                      text: state.isLoading
                          ? 'common.loading'.tr()
                          : 'auth.sign_in'.tr(),
                      onPressed: state.isLoading
                          ? null
                          : () {
                              context.read<LoginCubit>().login(
                                phoneController.text.trim(),
                                passwordController.text.trim(),
                              );
                            },
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () => context.pushNamed(Routes.registerScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'auth.no_account'.tr(),
                            style: TextStyles.gray16Medium,
                          ),
                          Text(
                            'auth.sign_up'.tr(),
                            style: TextStyles.orange16SemiBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
