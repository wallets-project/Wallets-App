import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/auth/logic/logout/cubit/logout_cubit.dart';
import 'package:wallets/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wallets/features/profile/logic/cubit/profile_state.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: ColorsManager.blueblode,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final user = state.user;
                        final name = user?.name?.trim();
                        final email = user?.email?.trim();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (name != null && name.isNotEmpty)
                                  ? name
                                  : 'common.user'.tr(),
                              style: TextStyles.white16Medium,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              (email != null && email.isNotEmpty)
                                  ? email
                                  : 'common.no_email'.tr(),
                              style: TextStyles.white16Medium.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _DrawerSectionTitle(title: 'common.quick_actions'.tr()),
          _DrawerItem(
            icon: Icons.dashboard,
            title: 'common.dashboard'.tr(),
            onTap: () => context.pop(),
          ),
          _DrawerItem(
            icon: Icons.account_balance_wallet,
            title: 'common.wallets'.tr(),
            onTap: () => context.pushNamed(Routes.walletsScreen),
          ),
          _DrawerItem(
            icon: Icons.send,
            title: 'common.transfer'.tr(),
            onTap: () => context.pushNamed(Routes.transferScreen),
          ),
          _DrawerItem(
            icon: Icons.history,
            title: 'common.transaction_history'.tr(),
            onTap: () => context.pushNamed(Routes.transactionHistoryScreen),
          ),
          _DrawerItem(
            icon: Icons.person_outline,
            title: 'common.my_profile'.tr(),
            onTap: () => context.pushNamed(Routes.profilescreen),
          ),
          SizedBox(height: 8.h),
          _DrawerSectionTitle(title: 'common.security_settings'.tr()),
          _DrawerItem(
            icon: Icons.edit,
            title: 'common.edit_profile'.tr(),
            onTap: () => context.pushNamed(Routes.editprofilescreen),
          ),
          _DrawerItem(
            icon: Icons.lock_outline,
            title: 'common.security_settings'.tr(),
          ),
          _DrawerItem(
            icon: Icons.notifications_none,
            title: 'common.notifications'.tr(),
          ),
          _DrawerItem(icon: Icons.language, title: 'common.language'.tr()),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () async {
                await context.read<LogoutCubit>().logout();
                if (!context.mounted) {
                  return;
                }
                await context.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  predicate: (_) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: ColorsManager.lightRed,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: ColorsManager.read),
                    SizedBox(width: 12.w),
                    Text(
                      'common.logout'.tr(),
                      style: TextStyles.black16Medium.copyWith(
                        color: ColorsManager.read,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final String title;

  const _DrawerSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(title, style: TextStyles.gray14Medium),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _DrawerItem({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: ColorsManager.blueblode),
      title: Text(title, style: TextStyles.black16Medium),
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
    );
  }
}
