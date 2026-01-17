import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/onboarding/ui/widgets/card_language.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svgs/wallets.svg'),
            SizedBox(height: 24.h),
            Text(
              'onboarding.select_language'.tr(),
              style: TextStyles.blue16Medium,
            ),
            SizedBox(height: 16.h),
            Text(
              'onboarding.choose_language'.tr(),
              style: TextStyles.gray16Medium,
            ),
            SizedBox(height: 48.h),
            CardLanguage(
              lang: 'onboarding.english'.tr(),
              cuntry: 'onboarding.united_states'.tr(),
              image: 'assets/svgs/us.svg',
              locale: const Locale('en'),
            ),
            CardLanguage(
              lang: 'onboarding.arabic'.tr(),
              cuntry: 'onboarding.palestine'.tr(),
              image: 'assets/svgs/ps.svg',
              locale: const Locale('ar'),
            ),
          ],
        ),
      ),
    );
  }
}
