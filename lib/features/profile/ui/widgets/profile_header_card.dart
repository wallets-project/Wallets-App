
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String walletId;

  const ProfileHeaderCard({super.key, 
    required this.name,
    required this.email,
    required this.phone,
    required this.walletId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.blueblode,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: ColorsManager.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 26.h,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyles.white16Medium),
                    SizedBox(height: 2.h),
                    Text(
                      email,
                      style: TextStyles.white16Medium.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      phone,
                      style: TextStyles.white16Medium.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Text(
                  'common.wallet_id'.tr(),
                  style: TextStyles.white16Medium.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const Spacer(),
                Text(walletId, style: TextStyles.white16Medium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
