import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gng_seller/model/menu_item.dart';
import 'package:gng_seller/model/shop.dart';

class Seller {
  Seller({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
    List<Shop>? shops,
  }) : shops = shops ?? [];

  final String uid;
  String name;
  String email;
  String? imageUrl;
  String phone;
  List<Shop> shops;

  // Convert Seller to a map, including nested shops
  Map<String, dynamic> toFireStore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'shops': shops.map((shop) => shop.toFireStore()).toList(),
    };
  }

  // Factory constructor to create a Seller from Firestore data
  factory Seller.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    Seller seller = Seller(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      imageUrl: data['imageUrl'],
    );

    // Check if there are shop data and populate Seller's shops list
    if (data['shops'] != null) {
      List<dynamic> shopsData = data['shops'] as List<dynamic>;
      seller.shops = shopsData.map((shopData) {
        Shop shop = Shop(
          shopId: shopData['shopId'],
          sellerId: shopData['sellerId'],
          name: shopData['name'],
          shortDescription: shopData['shortDescription'],
          description: shopData['description'],
          imageUrl: shopData['imageUrl'],
          address: shopData['address'],
        );

        // Handle menuItems for each shop
        if (shopData['menuItems'] != null) {
          List<dynamic> menuItemsData = shopData['menuItems'] as List<dynamic>;
          shop.menu = menuItemsData.map((menuItemData) {
            return MenuItem(
              itemId: menuItemData['itemId'],
              shopId: menuItemData['shopId'],
              name: menuItemData['name'],
              price: menuItemData['price'],
              description: menuItemData['description'],
              imageUrl: menuItemData['imageUrl'],
            );
          }).toList();
        }
        return shop;
      }).toList();
    }

    return seller;
  }

  // Add a shop to the seller's shop list
  void addShop(Shop shop) {
    shops.add(shop);
  }
}
