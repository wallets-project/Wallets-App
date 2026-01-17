import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class CardLanguage extends StatelessWidget {
  final String lang;
  final String cuntry;
  final String image;
  final Locale locale;

  const CardLanguage({
    super.key,
    required this.lang,
    required this.cuntry,
    required this.image,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.setLocale(locale);
        if (!context.mounted) {
          return;
        }
        context.pushReplacementNamed(Routes.getStartScreen);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.sp),
                    color: ColorsManager.grayBackGround,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: SvgPicture.asset(image, width: 5.w, height: 10.h),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lang, style: TextStyles.blue16Medium),
                    Text(cuntry, style: TextStyles.gray16Medium),
                  ],
                ),
                const Spacer(),
                Icon(Icons.check_circle_outline_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
