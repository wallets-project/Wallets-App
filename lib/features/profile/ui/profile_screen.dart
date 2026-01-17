import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wallets/features/profile/logic/cubit/profile_state.dart';
import 'package:wallets/features/profile/ui/widgets/logout_button.dart';
import 'package:wallets/features/profile/ui/widgets/profile_header_card.dart';
import 'package:wallets/features/profile/ui/widgets/profile_item.dart';
import 'package:wallets/features/profile/ui/widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> changeLanguage(Locale locale) async {
      await context.setLocale(locale);
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
    }

    void showLanguageSheet() {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        builder: (sheetContext) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('onboarding.arabic'.tr()),
                  trailing: context.locale.languageCode == 'ar'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => changeLanguage(const Locale('ar')),
                ),
                ListTile(
                  title: Text('onboarding.english'.tr()),
                  trailing: context.locale.languageCode == 'en'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => changeLanguage(const Locale('en')),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.profile'.tr(), style: TextStyles.blue16bold),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final user = state.user;
          final name = user?.name?.trim();
          final email = user?.email?.trim();
          final phone = user?.phone?.trim();
          final walletId = user?.id;
          final displayName = (name != null && name.isNotEmpty)
              ? name
              : 'common.user'.tr();
          final displayEmail = (email != null && email.isNotEmpty)
              ? email
              : 'common.no_email'.tr();
          final displayPhone = (phone != null && phone.isNotEmpty)
              ? phone
              : '---';
          final displayWalletId = walletId != null
              ? walletId.toString()
              : '---';
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                ProfileHeaderCard(
                  name: displayName,
                  email: displayEmail,
                  phone: displayPhone,
                  walletId: displayWalletId,
                ),
                SizedBox(height: 24.h),
                ProfileSection(
                  children: [
                    ProfileItem(
                      icon: Icons.person_outline,
                      title: 'common.edit_profile'.tr(),
                      onTap: () => context.pushNamed(Routes.editprofilescreen),
                    ),
                    SizedBox(height: 16.h),
                    ProfileItem(
                      icon: Icons.lock_outline,
                      title: 'common.security_settings'.tr(),
                    ),
                    SizedBox(height: 16.h),

                    ProfileItem(
                      icon: Icons.notifications_none,
                      title: 'common.notifications'.tr(),
                    ),
                    SizedBox(height: 16.h),

                    ProfileItem(
                      icon: Icons.language,
                      title: 'common.language'.tr(),
                      trailing: context.locale.languageCode == 'ar'
                          ? 'onboarding.arabic'.tr()
                          : 'onboarding.english'.tr(),
                      onTap: showLanguageSheet,
                    ),
                    SizedBox(height: 16.h),

                    ProfileItem(
                      icon: Icons.info_outline,
                      title: 'common.about'.tr(),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
                SizedBox(height: 24.h),
                ProfileSection(
                  children: [
                    ProfileItem(
                      icon: Icons.info_outline,
                      title: 'common.version'.tr(),
                      trailing: 'v1.0.0',
                      showArrow: false,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                LogoutButton(onTap: () {}),
              ],
            ),
          );
        },
      ),
    );
  }
}
