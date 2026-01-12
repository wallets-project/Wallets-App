import 'package:wallets/features/transfer/data/models/recipient_model.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';

class TransferState {
  final WalletItem? selectedWallet;

  final String recipientValue;
  final String amountValue;
  final String noteValue;

  final double availableBalance;

  final bool isValid;
  final bool isSubmitting;
  final String? statusMessage;
  final bool statusIsSuccess;
  final List<Recipient> recipients;
  final List<Recipient> allRecipients;
  final bool isRecipientsLoading;
  final String? recipientsError;

  const TransferState({
    required this.selectedWallet,
    required this.recipientValue,
    required this.amountValue,
    required this.noteValue,
    required this.availableBalance,
    required this.isValid,
    required this.isSubmitting,
    required this.statusMessage,
    required this.statusIsSuccess,
    required this.recipients,
    required this.allRecipients,
    required this.isRecipientsLoading,
    required this.recipientsError,
  });

  factory TransferState.initial() => const TransferState(
        selectedWallet: null,
        recipientValue: '',
        amountValue: '',
        noteValue: '',
        availableBalance: 0,
        isValid: false,
        isSubmitting: false,
        statusMessage: null,
        statusIsSuccess: false,
        recipients: <Recipient>[],
        allRecipients: <Recipient>[],
        isRecipientsLoading: false,
        recipientsError: null,
      );

  TransferState copyWith({
    WalletItem? selectedWallet,
    String? recipientValue,
    String? amountValue,
    String? noteValue,
    double? availableBalance,
    bool? isValid,
    bool? isSubmitting,
    String? statusMessage,
    bool? statusIsSuccess,
    List<Recipient>? recipients,
    List<Recipient>? allRecipients,
    bool? isRecipientsLoading,
    String? recipientsError,
    bool clearStatusMessage = false,
  }) {
    final message = clearStatusMessage ? null : (statusMessage ?? this.statusMessage);
    final success =
        clearStatusMessage ? false : (statusIsSuccess ?? this.statusIsSuccess);

    return TransferState(
      selectedWallet: selectedWallet ?? this.selectedWallet,
      recipientValue: recipientValue ?? this.recipientValue,
      amountValue: amountValue ?? this.amountValue,
      noteValue: noteValue ?? this.noteValue,
      availableBalance: availableBalance ?? this.availableBalance,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      statusMessage: message,
      statusIsSuccess: success,
      recipients: recipients ?? this.recipients,
      allRecipients: allRecipients ?? this.allRecipients,
      isRecipientsLoading: isRecipientsLoading ?? this.isRecipientsLoading,
      recipientsError: recipientsError ?? this.recipientsError,
    );
  }
}
