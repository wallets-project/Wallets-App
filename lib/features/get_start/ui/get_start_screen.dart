import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/features/get_start/ui/widgets/info_detailes.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svgs/wallets.svg'),
                SizedBox(height: 24.h),
                Text(
                  'get_start.title'.tr(),
                  style: TextStyles.blue16Medium,
                ),
                SizedBox(height: 12.h),

                Text(
                  'get_start.subtitle'.tr(),
                  style: TextStyles.gray16Medium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),

                InfoDetailes(
                  image: 'assets/svgs/v1.svg',
                  title: 'get_start.feature_secure_title'.tr(),
                  des: 'get_start.feature_secure_desc'.tr(),
                ),
                InfoDetailes(
                  image: 'assets/svgs/v2.svg',
                  title: 'get_start.feature_fast_title'.tr(),
                  des: 'get_start.feature_fast_desc'.tr(),
                ),
                InfoDetailes(
                  image: 'assets/svgs/v3.svg',
                  title: 'get_start.feature_multi_title'.tr(),
                  des: 'get_start.feature_multi_desc'.tr(),
                ),

                SizedBox(height: 25.h),
                MyButton(
                  onPressed: () => context.pushNamed(Routes.loginScreen),
                  text: 'get_start.get_start'.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
