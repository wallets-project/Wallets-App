import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_cubit.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacementNamed(
            Routes.otpScreen,
            arguments: phoneController.text.trim(),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('auth.register_success'.tr())),
          );
        }
        if (state.erorrMesseage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.erorrMesseage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('auth.register'.tr(), style: TextStyles.black20SemiBold),
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
                  Text('auth.sign_up'.tr(), style: TextStyles.black20SemiBold),
                  SizedBox(height: 7.h),
                  Text(
                    'auth.create_wallet_account'.tr(),
                    style: TextStyles.gray16Medium,
                  ),
                  SizedBox(height: 34.h),
                  FieldWidget(
                    label: 'form.full_name'.tr(),
                    controller: nameController,
                    hintText: 'form.full_name_hint'.tr(),
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 15.h),
                  FieldWidget(
                    label: 'form.phone'.tr(),
                    controller: phoneController,
                    hintText: 'form.phone_hint'.tr(),
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 15.h),
                  FieldWidget(
                    label: 'form.email'.tr(),
                    controller: emailController,
                    hintText: 'form.email_hint'.tr(),
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15.h),
                  FieldWidget(
                    label: 'form.password'.tr(),
                    controller: passwordController,
                    hintText: 'form.password_hint'.tr(),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 15.h),
                  FieldWidget(
                    label: 'form.confirm_password'.tr(),
                    controller: passwordController,
                    hintText: 'form.password_hint'.tr(),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 44.h),
                  MyButton(
                    text: state.isLoading
                        ? 'common.loading'.tr()
                        : 'auth.sign_up'.tr(),
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<RegisterCubit>().register(
                              nameController.text.trim(),
                              phoneController.text.trim(),
                              passwordController.text.trim(),
                              emailController.text.trim(),
                            );
                          },
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'auth.already_have_account'.tr(),
                        style: TextStyles.gray16Medium,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.loginScreen);
                        },
                        child: Text(
                          'auth.sign_in'.tr(),
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
      },
    );
  }
}
