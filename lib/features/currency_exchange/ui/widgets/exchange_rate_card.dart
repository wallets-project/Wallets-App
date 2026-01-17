
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class ExchangeRateCard extends StatelessWidget {
  const ExchangeRateCard({
    super.key,
    required WalletItem fromWallet,
    required WalletItem toWallet,
  }) : _fromWallet = fromWallet, _toWallet = toWallet;

  final WalletItem _fromWallet;
  final WalletItem _toWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_outward_outlined,
                  color: ColorsManager.green,
                ),
                Text('common.exchange_rate'.tr(), style: TextStyles.gray16Medium),
                Spacer(),
                Text('common.live'.tr(), style: TextStyles.green16Medium),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 65.w,
                  vertical: 16.h,
                ),
                child: Text(
                  '1 ${_fromWallet.currencyCode} = 0.85 ${_toWallet.currencyCode}',
                  style: TextStyles.blue16bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
