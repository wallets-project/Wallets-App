import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/features/transfer/data/models/recipient_model.dart';
import 'package:wallets/features/transfer/data/models/transfer_model.dart';
import 'package:wallets/features/transfer/data/repo/transfer_repo.dart';

class TransferRepoImpl extends TransferRepo {
  final ApiService api;
  TransferRepoImpl(this.api);

  @override
  Future<TransferResponse> transferFunds({
    required int walletId,
    required String recipientId,
    required double amount,
    required String note,
  }) async {
    final res = await api.post(
      '${ApiConstants.baseApiUrl}/api/v1/wallets/transfer',
      data: {
        'wallet_id': walletId,
        'to_phone': recipientId,
        'amount': amount,
        'note': note,
      },
    );
    return TransferResponse.fromJson(res);
  }

  @override
  Future<List<Recipient>> fetchRecipients({String? query}) async {
    final response = await api.get(
      '${ApiConstants.baseApiUrl}/api/v1/users',
      queryParameters: query != null && query.trim().isNotEmpty
          ? {'search': query.trim()}
          : null,
    );
    final list = _extractRecipientsList(response);
    return list
        .map((e) => Recipient.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  List<dynamic> _extractRecipientsList(dynamic response) {
    if (response is List) return response;
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is List) return data;
      if (data is Map<String, dynamic>) {
        final nested = data['data'];
        if (nested is List) return nested;
      }
    }
    return [];
  }
}
