import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class SelectedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const SelectedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.grayBackGround),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: ColorsManager.lightPink,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: ColorsManager.orange, size: 20.h),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.black16Medium),
                SizedBox(height: 2.h),
                Text(subtitle, style: TextStyles.gray12Medium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
