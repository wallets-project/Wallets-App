import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class ExchangeWalletCard extends StatelessWidget {
  const ExchangeWalletCard({
    super.key,
    required this.title,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyBalanceText,
    required this.amountLabel,
    required this.amountValue,
    this.amountPrefix = '',
    this.availableLabel,
    this.availableValue,
    this.isAmountEditable = true,
    this.onCurrencyTap,
    this.iconBackgroundColor = ColorsManager.primaryColor,
    this.iconTextColor = Colors.black,
  });

  final String title;
  final String currencyCode;
  final String currencySymbol;
  final String currencyBalanceText;
  final String amountLabel;
  final String amountValue;
  final String amountPrefix;
  final String? availableLabel;
  final String? availableValue;
  final bool isAmountEditable;
  final VoidCallback? onCurrencyTap;
  final Color iconBackgroundColor;
  final Color iconTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.grayBackGround),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            // offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.black16Medium),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onCurrencyTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.grayLight),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Container(
                    height: 24.r,
                    width: 24.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      currencySymbol,
                      style: TextStyles.black14Medium.copyWith(
                        color: iconTextColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currencyCode, style: TextStyles.black14Medium),
                        SizedBox(height: 2.h),
                        Text(
                          currencyBalanceText,
                          style: TextStyles.gray12Medium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          if (isAmountEditable)
            TextFormField(
              initialValue: amountValue,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: amountPrefix.isEmpty ? null : amountPrefix,
                prefixStyle: TextStyles.gray14,
                hintText: amountLabel,
                hintStyle: TextStyles.gray12Medium,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: ColorsManager.grayBackGround),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: ColorsManager.grayBackGround),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: ColorsManager.grayLight),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorsManager.grayBackGround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(amountLabel, style: TextStyles.gray12Medium),
                  SizedBox(height: 2.h),
                  Text(amountValue, style: TextStyles.black14Medium),
                ],
              ),
            ),
          if (availableLabel != null || availableValue != null) ...[
            SizedBox(height: 6.h),
            if (availableLabel != null)
              Text(availableLabel!, style: TextStyles.gray12Medium),
            if (availableValue != null) ...[
              SizedBox(height: 2.h),
              Text(availableValue!, style: TextStyles.gray12Medium),
            ],
          ],
        ],
      ),
    );
  }
}
