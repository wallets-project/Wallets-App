import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/secure_withdrawal_card.dart';
import 'package:wallets/core/widgets/selection_bottom_sheet.dart';
import 'package:wallets/features/currency_exchange/ui/widgets/exchange_rate_card.dart';
import 'package:wallets/features/currency_exchange/ui/widgets/exchange_wallet_card.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

const WalletItem _kInitialExchangeWallet = WalletItem(
  id: 0,
  currencyCode: 'USD',
  balance: 0,
  symbol: '\$',
);

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({super.key, this.wallets = const []});

  final List<WalletItem> wallets;

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  late final List<WalletItem> _availableWallets;
  late WalletItem _fromWallet;
  late WalletItem _toWallet;

  @override
  void initState() {
    super.initState();
    _availableWallets = widget.wallets.isNotEmpty
        ? widget.wallets
        : const [_kInitialExchangeWallet];
    _fromWallet = _availableWallets.first;
    _toWallet = _availableWallets.length > 1
        ? _availableWallets[1]
        : _availableWallets.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('common.currency_exchange'.tr(), style: TextStyles.blue16bold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ExchangeWalletCard(
              title: 'exchange.from_wallet'.tr(),
              currencyCode: _fromWallet.currencyCode,
              currencySymbol: _fromWallet.symbol,
              currencyBalanceText:
                  '${_fromWallet.symbol} ${_fromWallet.formattedBalance}',
              amountLabel: 'exchange.amount'.tr(),
              amountValue: '0.00',
              amountPrefix: '${_fromWallet.symbol} ',
              availableLabel: 'exchange.available_label'.tr(
                namedArgs: {'symbol': _fromWallet.symbol},
              ),
              availableValue: _fromWallet.formattedBalance,
              iconBackgroundColor: Colors.black,
              iconTextColor: Colors.white,
              onCurrencyTap: () async {
                final picked = await _showCurrencySheet(
                  context,
                  wallets: _availableWallets,
                  selectedId: _fromWallet.id,
                );
                if (!mounted || picked == null) {
                  return;
                }
                setState(() => _fromWallet = picked);
              },
            ),
            SizedBox(height: 22.h),
            const _SwapCurrencyButton(),
            SizedBox(height: 12.h),
            ExchangeWalletCard(
              title: 'exchange.to_wallet'.tr(),
              currencyCode: _toWallet.currencyCode,
              currencySymbol: _toWallet.symbol,
              currencyBalanceText:
                  '${_toWallet.symbol} ${_toWallet.formattedBalance}',
              amountLabel: 'exchange.converted_amount'.tr(),
              amountValue: '0.00 ${_toWallet.currencyCode}',
              isAmountEditable: false,
              iconBackgroundColor: ColorsManager.orange,
              iconTextColor: Colors.white,
              onCurrencyTap: () async {
                final picked = await _showCurrencySheet(
                  context,
                  wallets: _availableWallets,
                  selectedId: _toWallet.id,
                );
                if (!mounted || picked == null) {
                  return;
                }
                setState(() => _toWallet = picked);
              },
            ),
            SizedBox(height: 24.h),
            ExchangeRateCard(fromWallet: _fromWallet, toWallet: _toWallet),
           
            SizedBox(height: 24.h),
            SecureWithdrawalCard(
              title: 'withdraw.secure_withdrawal_title'.tr(),
              message: 'withdraw.secure_withdrawal_message'.tr(),
            ),
            SizedBox(height: 24.h),
            MyButton(text: 'common.continue'.tr(), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

Future<WalletItem?> _showCurrencySheet(
  BuildContext context, {
  required List<WalletItem> wallets,
  required int selectedId,
}) {
  return showSelectionBottomSheet<WalletItem>(
    context: context,
    title: 'exchange.choose_currency'.tr(),
    items: wallets,
    isSelected: (wallet) => wallet.id == selectedId,
    leadingBuilder: (wallet) => _CurrencyIcon(symbol: wallet.symbol),
    titleBuilder: (wallet) => wallet.currencyCode,
    subtitleBuilder: (wallet) => '${wallet.symbol} ${wallet.formattedBalance}',
  );
}

class _CurrencyIcon extends StatelessWidget {
  const _CurrencyIcon({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12.r),
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

class _SwapCurrencyButton extends StatelessWidget {
  const _SwapCurrencyButton();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -10.h),
      child: Container(
        height: 34.h,
        width: 34.w,
        decoration: BoxDecoration(
          color: ColorsManager.orange,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
        ),
        child: const Icon(Icons.swap_vert, color: Colors.white, size: 18),
      ),
    );
  }
}
