import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';
import 'package:wallets/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wallets/features/profile/logic/cubit/profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.edit_profile'.tr(), style: TextStyles.blue16bold),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final user = state.user;
          final name = user?.name?.trim();
          final email = user?.email?.trim();
          final phone = user?.phone?.trim();
          final displayName = (name != null && name.isNotEmpty)
              ? name
              : 'common.user'.tr();
          final displayEmail = (email != null && email.isNotEmpty)
              ? email
              : 'common.no_email'.tr();
          final displayPhone = (phone != null && phone.isNotEmpty)
              ? phone
              : '---';

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48.r,
                      backgroundColor: ColorsManager.orange,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 32.h,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorsManager.grayBackGround),
                      ),
                      child: Icon(
                        Icons.photo_camera,
                        size: 14.h,
                        color: ColorsManager.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                FieldWidget(
                  label: 'form.full_name'.tr(),
                  controller: TextEditingController(text: displayName),
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: 16.h),
                FieldWidget(
                  label: 'form.email'.tr(),
                  controller: TextEditingController(text: displayEmail),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                FieldWidget(
                  label: 'form.phone'.tr(),
                  controller: TextEditingController(text: displayPhone),
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 24.h),
                MyButton(text: 'common.save'.tr(), onPressed: () {}),
              ],
            ),
          );
        },
      ),
    );
  }
}
