
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final bool showArrow;
  final VoidCallback? onTap;

  const ProfileItem({super.key, 
    required this.icon,
    required this.title,
    this.trailing,
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: ColorsManager.grayBackGround,
        child: Icon(icon, color: ColorsManager.mainBlue, size: 18.h),
      ),
      title: Text(title, style: TextStyles.black16Medium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(trailing!, style: TextStyles.gray12Medium),
          if (showArrow)
            Icon(Icons.chevron_right, color: ColorsManager.gray, size: 20.h),
        ],
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
    );
  }
}
