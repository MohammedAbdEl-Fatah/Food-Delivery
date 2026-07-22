part of 'price.cubit.dart';

class PriceStatus {
  final int quantity;
  final int totalprice;

  PriceStatus({required this.quantity, required this.totalprice});
  PriceStatus copyWith({int? quantity, int? totalprice}) {
    return PriceStatus(
      quantity: quantity ?? this.quantity,
      totalprice: totalprice ?? this.totalprice,
    );
  }
}
