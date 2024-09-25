import 'package:gng_seller/model/menu_item.dart';

class Shop {
  Shop({
    required this.shopId,
    required this.sellerId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    required this.address,
    List<MenuItem>? menu,
  }) : menu = menu ?? [];

  final String? shopId;
  final String? sellerId;
  final String? name;
  final String? shortDescription;
  final String? description;
  final String? imageUrl;
  final String? address;
  List<MenuItem> menu;

  // Convert Shop to Firestore map, including nested menu items
  Map<String, dynamic> toFireStore() {
    return {
      'shopId': shopId,
      'sellerId': sellerId,
      'name': name,
      'shortDescription': shortDescription,
      'description': description,
      'imageUrl': imageUrl,
      'address': address,
      'menu': menu.map((item) => item.toFireStore()).toList(),
    };
  }

  // Add a menu item to the shop's menu list
  void addMenu(MenuItem item) {
    menu.add(item);
  }
}
