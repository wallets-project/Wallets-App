import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/logic/cubit/home_state.dart';
import 'package:wallets/features/wallets/widgets/add_wallet_tile.dart';
import 'package:wallets/features/wallets/widgets/create_wallet_bottom_sheet.dart';
import 'package:wallets/features/wallets/widgets/total_balance_card.dart';
import 'package:wallets/features/wallets/widgets/wallet_item_tile.dart';

class WalletsSCreen extends StatelessWidget {
  const WalletsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onAddWalletTap(BuildContext context) {
      final homeCubit = context.read<HomeCubit>();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => BlocProvider.value(
          value: homeCubit,
          child: const CreateWalletBottomSheet(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        title: Text('common.wallets'.tr(), style: TextStyles.blue20Bold),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final walletsResponse = state.wallets;

          // First load states
          if (walletsResponse == null) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
            return const SizedBox.shrink();
          }

          final data = walletsResponse.data;
          if (data == null || data.wallets.isEmpty) {
            return Center(child: Text('common.no_wallets'.tr()));
          }

          final total = data.totalBalanceUSD ?? 0.0;
          final trans = data.monthlyTransfersUsd ?? 0.0;

          final content = SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  TotalBalanceCard(
                    title: 'common.total_balance'.tr(),
                    totalText: '\$ ${total.toStringAsFixed(2)}',
                    changeText: '+${trans.toStringAsFixed(2)}%',
                    compareText: 'wallets.vs_last_month'.tr(),
                    icon: Icons.trending_up,
                  ),

                  SizedBox(height: 24.h),

                  ...data.wallets.map((w) {
                    final name = w.currencyName ?? 'wallets.wallet_fallback'.tr();
                    final code = w.currency ?? '';
                    final amount = w.balance ?? 0.0;
                    final lastAmount = w.lastIncomingTransfer;
                    String changeText = '';
                    if (lastAmount is num) {
                      changeText = '+${lastAmount.toStringAsFixed(2)}%';
                    } else if (lastAmount is String) {
                      final parsed = double.tryParse(lastAmount);
                      if (parsed != null) {
                        changeText = '+${parsed.toStringAsFixed(2)}%';
                      }
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: WalletItemTile(
                        name: name,
                        code: code,
                        amountText: '$code ${amount.toStringAsFixed(2)}',
                        changeText: changeText,
                        icon: Icons.attach_money,
                        iconBg: ColorsManager.blueblode,
                      ),
                    );
                  }),

                  SizedBox(height: 24.h),

                  AddWalletTile(
                    title: 'wallets.add_wallet'.tr(),
                    onTap: () => onAddWalletTap(context),
                  ),
                ],
              ),
            ),
          );

          if (!state.isLoading) {
            return content;
          }

          return Stack(
            children: [
              content,
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.05),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
