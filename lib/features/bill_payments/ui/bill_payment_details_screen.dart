import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/amount_section_card.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/wallet_selector_card.dart';
import 'package:wallets/features/bill_payments/ui/widgets/SelectedrCard.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class BillPaymentDetailsScreen extends StatelessWidget {
  const BillPaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.bill_payments'.tr(), style: TextStyles.blue16bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          child: Column(
            children: [
              SelectedCard(
                title: 'bill.saudi_electricity_company'.tr(),
                subtitle: 'bill.electricity'.tr(),
                icon: Icons.electric_bolt,
              ),
              SizedBox(height: 24.h),
              AmountSectionCard(
                controller: TextEditingController(),
                onChanged: (value) => {},
                title: 'bill.account_number'.tr(),
              ),
              SizedBox(height: 24.h),
              WalletSelectorCard(
                wallets: [],
                selectedWallet: WalletItem(
                  balance: 100,
                  currencyCode: 'USD',
                  id: 1,
                  symbol: '\$',
                ),
                onWalletChanged: (value) {},
              ),
              SizedBox(height: 24.h),
              AmountSectionCard(
                controller: TextEditingController(),
                onChanged: (value) => {},
                title: 'bill.amount'.tr(),
              ),
              SizedBox(height: 24.h),
              MyButton(text: 'common.continue'.tr(), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
