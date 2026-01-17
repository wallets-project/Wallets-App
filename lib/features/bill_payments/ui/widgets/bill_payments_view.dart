import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class BillPaymentsView extends StatelessWidget {
  const BillPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      BillCategoryData(
        title: 'bill.electricity'.tr(),
        icon: Icons.electric_bolt,
        iconColor: ColorsManager.orange,
        iconBackground: ColorsManager.lightPink,
      ),
      BillCategoryData(
        title: 'bill.water'.tr(),
        icon: Icons.water_drop,
        iconColor: ColorsManager.blue,
        iconBackground: ColorsManager.lightBlue,
      ),
      BillCategoryData(
        title: 'bill.internet'.tr(),
        icon: Icons.wifi,
        iconColor: ColorsManager.green,
        iconBackground: ColorsManager.lightGreen,
      ),
      BillCategoryData(
        title: 'bill.gas'.tr(),
        icon: Icons.local_gas_station,
        iconColor: ColorsManager.red,
        iconBackground: ColorsManager.lightRed,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.bill_payments'.tr(), style: TextStyles.blue16bold),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('common.select_category'.tr(), style: TextStyles.black16Bold),
            SizedBox(height: 24.h),
            BillPaymentsGrid(categories: categories),
          ],
        ),
      ),
    );
  }
}

class BillPaymentsGrid extends StatelessWidget {
  final List<BillCategoryData> categories;

  const BillPaymentsGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) => BillCategoryCard(
        data: categories[index],
        onTap: () {
          context.pushNamed(Routes.selectproviderscreen);
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 190.w / 147.h,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
    );
  }
}

class BillCategoryCard extends StatelessWidget {
  final BillCategoryData data;
  final VoidCallback? onTap;

  const BillCategoryCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 147.h,
        width: 190.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.grayBackGround),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: data.iconBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(data.icon, size: 48.h, color: data.iconColor),
                ),
              ),
              SizedBox(height: 16.h),
              Text(data.title, style: TextStyles.black16Medium),
            ],
          ),
        ),
      ),
    );
  }
}

class BillCategoryData {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  const BillCategoryData({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });
}
