// ignore: constant_identifier_names
enum PhoneBrand { Samsung, iPhone }

class Product {
  final int id;
  final String name;
  final int price;
  final PhoneBrand brand;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
