import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/Summary_section_card.dart';
import 'package:wallets/core/widgets/amount_section_card.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/secure_withdrawal_card.dart';
import 'package:wallets/core/widgets/wallet_selector_card.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class TopUp extends StatelessWidget {
  const TopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Withdraw Funds', style: TextStyles.blue16bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
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
                availableText: 'Available: \$100.00',
                onChanged: (value) {},
              ),
              SizedBox(height: 24.h),
              SummarySectionCard(),
              SizedBox(height: 24.h),
              SecureWithdrawalCard(),
              SizedBox(height: 24.h),

              MyButton(text: 'Continue', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
