import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';

class SummarySectionCard extends StatelessWidget {
  const SummarySectionCard({
    super.key,
    this.title = 'Summary',
    this.amountLabel = 'Amount',
    this.amountValue = '\$100.00',
    this.feeLabel = 'Withdrawal Fee',
    this.feeValue = '-\$100.00',
    this.totalLabel = 'You will receive',
    this.totalValue = '+\$100.00',
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.padding,
    this.showDivider = true,
  });

  final String title;
  final String amountLabel;
  final String amountValue;
  final String feeLabel;
  final String feeValue;
  final String totalLabel;
  final String totalValue;

  final Color backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.black16Bold),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(amountLabel, style: TextStyles.gray16Medium),
                Text(amountValue, style: TextStyles.black16Medium),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(feeLabel, style: TextStyles.gray16Medium),
                Text(feeValue, style: TextStyles.red16Medium),
              ],
            ),
            if (showDivider) ...[
              SizedBox(height: 8.h),
              Divider(),
              SizedBox(height: 8.h),
            ],

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(totalLabel, style: TextStyles.black16Bold),
                Text(totalValue, style: TextStyles.green16Medium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
