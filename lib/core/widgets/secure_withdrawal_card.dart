import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class SecureWithdrawalCard extends StatelessWidget {
  const SecureWithdrawalCard({
    super.key,
    this.title = 'Secure Withdrawal',
    this.message =
        'Funds will be transferred to your bank account within 1-3 business days.',
    this.icon = Icons.shield_outlined,
    this.iconColor = ColorsManager.orange,
    this.backgroundColor = const Color(0xFFF9F2E1),
  });

  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.black16Bold),
                SizedBox(height: 6.h),
                Text(message, style: TextStyles.gray14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
