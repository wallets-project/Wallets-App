import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
                  'Secure Digital Wallet',
                  style: TextStyles.blue16Medium,
                ),
                SizedBox(height: 12.h),

                Text(
                  'Fast, secure, and reliable hybrid wallet for all your financial needs',
                  style: TextStyles.gray16Medium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),

                InfoDetailes(
                  image: 'assets/svgs/v1.svg',
                  title: 'Secure & Safe',
                  des: 'Bank-level security for all your transactions',
                ),
                InfoDetailes(
                  image: 'assets/svgs/v2.svg',
                  title: 'Fast Transfers',
                  des: 'Instant transfers to any wallet worldwide',
                ),
                InfoDetailes(
                  image: 'assets/svgs/v3.svg',
                  title: 'Multi-Currency',
                  des: 'Support for multiple currencies and exchanges',
                ),

                SizedBox(height: 25.h),
                MyButton(
                  onPressed: () => context.pushNamed(Routes.loginScreen),
                  text: 'Get Start',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
