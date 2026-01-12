class Recipient {
  final String id;
  final String name;
  final String? walletId;
  final String? phone;

  const Recipient({
    required this.id,
    required this.name,
    this.walletId,
    this.phone,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json['id']?.toString() ?? json['wallet_id']?.toString() ?? '',
      name: json['name'] ?? json['full_name'] ?? '',
      walletId: json['wallet_id']?.toString(),
      phone: json['phone']?.toString(),
    );
  }

  String get displayId => walletId?.isNotEmpty == true
      ? walletId!
      : phone?.isNotEmpty == true
          ? phone!
          : id;
}
