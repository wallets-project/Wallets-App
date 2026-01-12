import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/transfer/data/models/recipient_model.dart';
import 'package:wallets/features/transfer/data/models/transfer_model.dart';
import 'package:wallets/features/transfer/data/repo/transfer_repo.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final TransferRepo repo;

  TransferCubit(this.repo) : super(TransferState.initial());

  void setInitialWallet(WalletItem wallet) {
    final next = state.copyWith(
      selectedWallet: wallet,
      availableBalance: wallet.balance,
    );
    emit(next.copyWith(isValid: _validate(next)));
  }

  void onWalletChanged(WalletItem wallet) {
    final next = state.copyWith(
      selectedWallet: wallet,
      availableBalance: wallet.balance,
    );
    emit(next.copyWith(isValid: _validate(next)));
  }

  void onRecipientChanged(String value) {
    _filterRecipients(value);
  }

  void onRecipientSelected({required String name, required String id}) {
    _filterRecipients(id);
  }

  void onAmountChanged(String value) {
    final next = state.copyWith(amountValue: value);
    emit(next.copyWith(isValid: _validate(next)));
  }

  void onNoteChanged(String value) {
    emit(state.copyWith(noteValue: value));
  }

  Future<void> submit() async {
    if (!state.isValid || state.isSubmitting) return;

    final wallet = state.selectedWallet!;
    final amount = double.parse(state.amountValue.trim());
    final rawBalance = wallet.balance - amount;
    final updatedBalance = rawBalance < 0 ? 0.0 : rawBalance;
    final updatedWallet = WalletItem(
      id: wallet.id,
      currencyCode: wallet.currencyCode,
      balance: updatedBalance,
      symbol: wallet.symbol,
    );

    emit(
      state.copyWith(
        isSubmitting: true,
        statusMessage: null,
        statusIsSuccess: false,
      ),
    );

    try {
      final TransferResponse response = await repo.transferFunds(
        walletId: wallet.id,
        recipientId: state.recipientValue.trim(),
        amount: amount,
        note: state.noteValue.trim(),
      );

      final message = response.message?.trim().isNotEmpty == true
          ? response.message!
          : 'تم تنفيذ التحويل بنجاح';

      emit(
        state.copyWith(
          isSubmitting: false,
          statusMessage: message,
          statusIsSuccess: true,
          selectedWallet: updatedWallet,
          availableBalance: updatedBalance,
          recipientValue: '',
          amountValue: '',
          noteValue: '',
          isValid: false,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          statusMessage: e.message,
          statusIsSuccess: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          statusMessage: 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى',
          statusIsSuccess: false,
        ),
      );
    }
  }

  Future<void> loadRecipients() async {
    emit(state.copyWith(
      isRecipientsLoading: true,
      recipientsError: null,
    ));
    try {
      final list = await repo.fetchRecipients();
      final filtered = _filterList(state.recipientValue, list);
      final updatedState = state.copyWith(
        isRecipientsLoading: false,
        recipients: filtered,
        allRecipients: list,
      );
      emit(updatedState.copyWith(isValid: _validate(updatedState)));
    } on ApiException catch (e) {
      emit(state.copyWith(
        isRecipientsLoading: false,
        recipientsError: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        isRecipientsLoading: false,
        recipientsError: 'فشل تحميل المستخدمين، حاول لاحقًا',
      ));
    }
  }

  void _filterRecipients(String query) {
    final filtered = _filterList(query, state.allRecipients);
    final updatedState = state.copyWith(
      recipients: filtered,
      recipientValue: query,
    );
    emit(updatedState.copyWith(isValid: _validate(updatedState)));
  }

  List<Recipient> _filterList(String query, List<Recipient> source) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return source;

    return source.where((recipient) {
      final haystack =
          '${recipient.name} ${recipient.displayId} ${recipient.phone ?? ''}'
              .toLowerCase();
      return haystack.contains(normalized);
    }).toList();
  }

  void clearStatusMessage() {
    if (state.statusMessage != null) {
      emit(state.copyWith(clearStatusMessage: true));
    }
  }

  bool _validate(TransferState s) {
    final hasWallet = s.selectedWallet != null;
    final recipientOk = s.recipientValue.trim().isNotEmpty;

    final amount = double.tryParse(s.amountValue.trim()) ?? 0;
    final amountOk = amount > 0;

    return hasWallet && recipientOk && amountOk;
  }
}
