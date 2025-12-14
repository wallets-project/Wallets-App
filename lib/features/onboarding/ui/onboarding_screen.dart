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
            Text('Select Language', style: TextStyles.blue16Medium),
            SizedBox(height: 8.h),
            Text('اختر اللغة', style: TextStyles.blue16Medium),
            SizedBox(height: 16.h),
            Text(
              'Choose your preferred language',
              style: TextStyles.gray16Medium,
            ),
            SizedBox(height: 48.h),
            CardLanguage(
              lang: "English",
              cuntry: "United States",
              image: 'assets/svgs/us.svg',
            ),

            CardLanguage(
              lang: "العربية",
              cuntry: "فلسطين",
              image: 'assets/svgs/ps.svg',
            ),
          ],
        ),
      ),
    );
  }
}
