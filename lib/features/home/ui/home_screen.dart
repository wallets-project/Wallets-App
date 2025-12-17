import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/data/wallet_balance_card_data.dart';
import 'package:wallets/features/home/ui/widgets/appbar_home.dart';
import 'package:wallets/features/home/ui/widgets/drawer_home.dart';
import 'package:wallets/features/home/ui/widgets/quick_action_card.dart';
import 'package:wallets/features/home/ui/widgets/transaction_item_card.dart';
import 'package:wallets/features/home/ui/widgets/wallet_summary_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      drawer: DrawerHome(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const AppBarHome(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletSummarySection(
              title: 'Total Balance',
              totalAmountText: '\$ 18,233.37',
              totalIcon: Icons.account_balance_wallet_outlined,
              cards: [
                WalletBalanceCardData(
                  currencyCode: 'USD',
                  amountText: '\$ 12,450.50',
                  icon: Icons.wallet,
                ),
                WalletBalanceCardData(
                  currencyCode: 'SAR',
                  amountText: 'SAR 2,500.00',
                  icon: Icons.wallet,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Actions', style: TextStyles.black16Bold),
                  SizedBox(height: 18),
                  QuickActionCard(
                    title: 'Top Up',
                    icon: Icons.arrow_circle_up_rounded,
                  ),
                  SizedBox(height: 16.h),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 2.4,
                    children: [
                      QuickActionCard(
                        title: 'Transfer',
                        icon: Icons.arrow_downward,
                        backgroundColor: Colors.white,
                        textStyle: TextStyles.black16Bold,
                        iconBackgroundColor: ColorsManager.orange.withAlpha(
                          100,
                        ),
                        iconColor: ColorsManager.orange,
                      ),
                      QuickActionCard(
                        title: 'Withdraw',
                        icon: Icons.credit_card,
                        backgroundColor: Colors.white,
                        textStyle: TextStyles.black16Bold,
                        iconBackgroundColor: ColorsManager.orange.withAlpha(
                          100,
                        ),
                        iconColor: ColorsManager.orange,
                      ),
                      QuickActionCard(
                        title: 'Exchange',
                        icon: Icons.sync,
                        backgroundColor: Colors.white,
                        textStyle: TextStyles.black16Bold,
                        iconBackgroundColor: ColorsManager.orange.withAlpha(
                          100,
                        ),
                        iconColor: ColorsManager.orange,
                      ),
                      QuickActionCard(
                        title: 'Bill Payment',
                        icon: Icons.attach_money,
                        backgroundColor: Colors.white,
                        textStyle: TextStyles.black16Bold,
                        iconBackgroundColor: ColorsManager.orange.withAlpha(
                          100,
                        ),
                        iconColor: ColorsManager.orange,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyles.black16Bold,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'View All',
                          style: TextStyles.orange16SemiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TransactionItemCard(
                    title: 'Top-up',
                    subtitle: 'Card Top-up',
                    dateTime: '2025-12-08 14:30',
                    amountText: '+USD 500.00',
                    icon: Icons.arrow_outward_rounded,
                    iconBackgroundColor: ColorsManager.lightGreen.withAlpha(
                      100,
                    ),
                    amountTextStyle: TextStyles.green16Medium,
                    showStatusIcon: true,
                    statusIconColor: ColorsManager.lightGreen,
                  ),
                  SizedBox(height: 16.h),
                  TransactionItemCard(
                    title: 'Top-up',
                    subtitle: 'Card Top-up',
                    dateTime: '2025-12-08 14:30',
                    amountText: '+USD 500.00',
                    icon: Icons.arrow_outward_rounded,
                    iconBackgroundColor: ColorsManager.lightGreen.withAlpha(
                      100,
                    ),
                    amountTextStyle: TextStyles.green16Medium,
                    showStatusIcon: true,
                    statusIconColor: ColorsManager.lightGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
