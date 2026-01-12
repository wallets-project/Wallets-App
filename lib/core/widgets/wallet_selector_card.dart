import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class WalletSelectorCard extends StatelessWidget {
  const WalletSelectorCard({
    super.key,
    required this.wallets,
    required this.selectedWallet,
    required this.onWalletChanged,
    this.title = 'Select Wallet',
  });

  final List<WalletItem> wallets;
  final WalletItem selectedWallet;
  final ValueChanged<WalletItem> onWalletChanged;
  final String title;

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
          Text(title, style: TextStyles.black16Medium),
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
    return showModalBottomSheet<WalletItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Choose Wallet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: wallets.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final w = wallets[index];
                      final bool isSelected = w.id == selectedId;

                      return ListTile(
                        onTap: () => Navigator.pop(context, w),
                        leading: _WalletIcon(symbol: w.symbol),
                        title: Text(
                          w.currencyCode,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('${w.symbol} ${w.formattedBalance}'),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const Icon(Icons.radio_button_off),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
