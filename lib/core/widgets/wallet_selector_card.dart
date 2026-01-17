import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/selection_bottom_sheet.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class WalletSelectorCard extends StatelessWidget {
  const WalletSelectorCard({
    super.key,
    required this.wallets,
    required this.selectedWallet,
    required this.onWalletChanged,
    this.title,
  });

  final List<WalletItem> wallets;
  final WalletItem selectedWallet;
  final ValueChanged<WalletItem> onWalletChanged;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'common.select_wallet'.tr(),
            style: TextStyles.black16Medium,
          ),
           SizedBox(height: 10.h),
          InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () async {
              final WalletItem? picked = await _showWalletPicker(
                context: context,
                wallets: wallets,
                selectedId: selectedWallet.id,
              );

              if (picked != null) onWalletChanged(picked);
            },
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  _WalletIcon(symbol: selectedWallet.symbol),
                   SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedWallet.currencyCode,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${selectedWallet.symbol} ${selectedWallet.formattedBalance}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<WalletItem?> _showWalletPicker({
    required BuildContext context,
    required List<WalletItem> wallets,
    required int selectedId,
  }) {
    return showSelectionBottomSheet<WalletItem>(
      context: context,
      title: 'common.choose_wallet'.tr(),
      items: wallets,
      isSelected: (wallet) => wallet.id == selectedId,
      leadingBuilder: (wallet) => _WalletIcon(symbol: wallet.symbol),
      titleBuilder: (wallet) => wallet.currencyCode,
      subtitleBuilder: (wallet) => '${wallet.symbol} ${wallet.formattedBalance}',
    );
  }
}

class _WalletIcon extends StatelessWidget {
  const _WalletIcon({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
