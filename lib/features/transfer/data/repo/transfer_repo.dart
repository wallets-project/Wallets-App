import 'package:wallets/features/transfer/data/models/recipient_model.dart';
import 'package:wallets/features/transfer/data/models/transfer_model.dart';

abstract class TransferRepo {
  Future<TransferResponse> transferFunds({
    required int walletId,
    required String recipientId,
    required double amount,
    required String note,
  });

  Future<List<Recipient>> fetchRecipients({String? query});
}
