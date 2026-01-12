class TransferResponse {
  final bool? status;
  final String? message;
  final String? code;
  final TransferData? data;

  TransferResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      data: json['data'] != null ? TransferData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = <String, dynamic>{};
    output['status'] = status;
    output['message'] = message;
    output['code'] = code;
    if (data != null) {
      output['data'] = data!.toJson();
    }
    return output;
  }
}

class TransferData {
  final TransactionDetail? debitTransaction;
  final TransactionDetail? creditTransaction;

  TransferData({
    this.debitTransaction,
    this.creditTransaction,
  });

  factory TransferData.fromJson(Map<String, dynamic> json) {
    return TransferData(
      debitTransaction: json['debit_transaction'] != null
          ? TransactionDetail.fromJson(json['debit_transaction'])
          : null,
      creditTransaction: json['credit_transaction'] != null
          ? TransactionDetail.fromJson(json['credit_transaction'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = <String, dynamic>{};
    if (debitTransaction != null) {
      output['debit_transaction'] = debitTransaction!.toJson();
    }
    if (creditTransaction != null) {
      output['credit_transaction'] = creditTransaction!.toJson();
    }
    return output;
  }
}

class TransactionDetail {
  final int? userId;
  final int? walletId;
  final String? type;
  final int? amount;
  final int? fee;
  final int? totalAmount;
  final int? balanceBefore;
  final int? balanceAfter;
  final String? status;
  final String? description;
  final String? reference;
  final TransactionMeta? meta;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  TransactionDetail({
    this.userId,
    this.walletId,
    this.type,
    this.amount,
    this.fee,
    this.totalAmount,
    this.balanceBefore,
    this.balanceAfter,
    this.status,
    this.description,
    this.reference,
    this.meta,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      userId: json['user_id'],
      walletId: json['wallet_id'],
      type: json['type'],
      amount: json['amount'],
      fee: json['fee'],
      totalAmount: json['total_amount'],
      balanceBefore: json['balance_before'],
      balanceAfter: json['balance_after'],
      status: json['status'],
      description: json['description'],
      reference: json['reference'],
      meta: json['meta'] != null ? TransactionMeta.fromJson(json['meta']) : null,
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = <String, dynamic>{};
    output['user_id'] = userId;
    output['wallet_id'] = walletId;
    output['type'] = type;
    output['amount'] = amount;
    output['fee'] = fee;
    output['total_amount'] = totalAmount;
    output['balance_before'] = balanceBefore;
    output['balance_after'] = balanceAfter;
    output['status'] = status;
    output['description'] = description;
    output['reference'] = reference;
    if (meta != null) {
      output['meta'] = meta!.toJson();
    }
    output['updated_at'] = updatedAt;
    output['created_at'] = createdAt;
    output['id'] = id;
    return output;
  }
}

class TransactionMeta {
  final String? direction;
  final int? toUserId;
  final int? fromUserId;
  final String? reference;
  final String? note;

  TransactionMeta({
    this.direction,
    this.toUserId,
    this.fromUserId,
    this.reference,
    this.note,
  });

  factory TransactionMeta.fromJson(Map<String, dynamic> json) {
    return TransactionMeta(
      direction: json['direction'],
      toUserId: json['to_user_id'],
      fromUserId: json['from_user_id'],
      reference: json['reference'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = <String, dynamic>{};
    output['direction'] = direction;
    output['to_user_id'] = toUserId;
    output['from_user_id'] = fromUserId;
    output['reference'] = reference;
    output['note'] = note;
    return output;
  }
}
