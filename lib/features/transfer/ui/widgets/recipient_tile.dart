
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class RecipientTile extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback onTap;

  const RecipientTile({
    super.key,
    required this.name,
    required this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorsManager.grayBackGround,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: ColorsManager.orange.withAlpha(140),
              child: Icon(Icons.person, color: Colors.white, size: 18.w),
            ),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyles.black16Medium),
                SizedBox(height: 4.h),
                Text(id, style: TextStyles.gray12Medium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
