import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/wallet_selector_card.dart';
import 'package:wallets/features/transfer/logic/cubit/transfer_cubit.dart';
import 'package:wallets/features/transfer/logic/cubit/transfer_state.dart';
import 'package:wallets/features/transfer/ui/widgets/amount_section_card.dart';
import 'package:wallets/features/transfer/ui/widgets/note_section_card.dart';
import 'package:wallets/features/transfer/ui/widgets/recipient_section_card.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

const WalletItem _kInitialTransferWallet = WalletItem(
  id: 0,
  currencyCode: 'USD',
  balance: 0,
  symbol: '\$',
);

class TransferScreen extends StatefulWidget {
  final List<WalletItem> wallets;

  const TransferScreen({super.key, this.wallets = const []});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  late final TextEditingController recipientController;
  late final TextEditingController amountController;
  late final TextEditingController noteController;
  late final List<WalletItem> _availableWallets;
  late final WalletItem _initialWallet;

  @override
  void initState() {
    super.initState();
    recipientController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
    _availableWallets = widget.wallets.isNotEmpty
        ? widget.wallets
        : const [_kInitialTransferWallet];
    _initialWallet = _availableWallets.first;
    final transferCubit = context.read<TransferCubit>();
    transferCubit.setInitialWallet(_initialWallet);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        transferCubit.loadRecipients();
      }
    });
  }

  @override
  void dispose() {
    recipientController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferCubit, TransferState>(
      listenWhen: (p, c) =>
          p.recipientValue != c.recipientValue ||
          p.amountValue != c.amountValue ||
          p.noteValue != c.noteValue ||
          p.statusMessage != c.statusMessage,
      listener: (context, state) {
        if (recipientController.text != state.recipientValue) {
          recipientController.text = state.recipientValue;
        }
        if (amountController.text != state.amountValue) {
          amountController.text = state.amountValue;
        }
        if (noteController.text != state.noteValue) {
          noteController.text = state.noteValue;
        }
        if (state.statusMessage != null) {
          final didSucceed = state.statusIsSuccess;
          final snack = SnackBar(
            content: Text(state.statusMessage!),
            backgroundColor: state.statusIsSuccess ? Colors.green : Colors.red,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snack);
          context.read<TransferCubit>().clearStatusMessage();
          if (didSucceed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.of(context).pop(true);
              }
            });
          }
        }
      },
      buildWhen: (p, c) => p != c,
      builder: (context, state) {
        final transferCubit = context.read<TransferCubit>();
        return Scaffold(
          backgroundColor: ColorsManager.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Transfer Money', style: TextStyles.blue16bold),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  WalletSelectorCard(
                    wallets: _availableWallets,
                    selectedWallet: state.selectedWallet ?? _initialWallet,
                    onWalletChanged: transferCubit.onWalletChanged,
                  ),

                  SizedBox(height: 16.h),

                  RecipientSectionCard(
                    controller: recipientController,
                    recipients: state.recipients,
                    onChanged: transferCubit.onRecipientChanged,
                    onRecipientTap: (name, id) =>
                        transferCubit.onRecipientSelected(name: name, id: id),
                    isLoading: state.isRecipientsLoading,
                    error: state.recipientsError,
                  ),

                  SizedBox(height: 16.h),

                  AmountSectionCard(
                    controller: amountController,
                    availableText:
                        'Available: \$${state.availableBalance.toStringAsFixed(2)}',
                    onChanged: transferCubit.onAmountChanged,
                  ),

                  SizedBox(height: 12.h),

                  NoteSectionCard(
                    controller: noteController,
                    onChanged: transferCubit.onNoteChanged,
                  ),

                  SizedBox(height: 18.h),

                  MyButton(
                    text: state.isSubmitting ? 'Processing...' : 'Continue',
                    onPressed: state.isValid
                        ? () => transferCubit.submit()
                        : () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
