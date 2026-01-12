class WalletItem {
  final int id;
  final String currencyCode; // USD
  final double balance; // 12450.50
  final String symbol; // $

  const WalletItem({
    required this.id,
    required this.currencyCode,
    required this.balance,
    required this.symbol,
  });

  String get formattedBalance => balance.toStringAsFixed(2);
}
