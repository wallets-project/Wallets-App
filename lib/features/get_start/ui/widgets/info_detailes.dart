import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/theming/styles.dart';

class InfoDetailes extends StatelessWidget {
  final String title;
  final String des;
  final String image;

  const InfoDetailes({
    super.key,
    required this.title,
    required this.des,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 48.w, height: 48.h, child: SvgPicture.asset(image)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.blue20Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  des,
                  style: TextStyles.gray16Medium,
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
