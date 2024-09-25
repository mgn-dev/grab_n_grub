
class MenuItem {
  MenuItem({
    required this.itemId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  final String? itemId;
  final String? shopId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final double? price;

  Map<String, dynamic> toFireStore() {
    return {
      'itemId': itemId,
      'shopId': shopId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price, 
    };
  }
}
