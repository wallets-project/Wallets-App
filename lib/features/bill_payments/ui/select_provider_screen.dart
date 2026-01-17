import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/bill_payments/ui/widgets/select_provider_card.dart';

class SelectProviderScreen extends StatelessWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.bill_payments'.tr(), style: TextStyles.blue16bold),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('common.select_provider'.tr(), style: TextStyles.black16Bold),
            SelectProviderCard(
              title: 'bill.saudi_electricity_company'.tr(),
              icon: Icons.electric_bolt,
              iconColor: ColorsManager.orange,
              onTap: () => context.pushNamed(Routes.billpaymentdetailsscreen),
            ),
          ],
        ),
      ),
    );
  }
}
