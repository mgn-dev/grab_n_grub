import 'package:flutter/material.dart';
import 'package:gng_seller/model/menu_item.dart';
import 'package:gng_seller/model/seller.dart';
import 'package:gng_seller/model/shop.dart';
import 'package:gng_seller/services/firestore_service.dart';

MenuItem item = MenuItem(
  itemId: "4drd4dx4srr",
  shopId: "4edr4rsxtrducfh",
  name: "Fortune Cookie",
  description: "Cookies that tell the future",
  imageUrl:
      "https://drive.google.com/file/d/1F_EL85s0bFc_Oq_Lc0YLFaZ53Ve0UfAX/view?usp=sharing",
  price: 23.00,
);

Shop shop = Shop(
  shopId: "4edr4rsxtrducfh",
  sellerId: "5ewy87DNuDWzw6f7QGSBbubDvAp1",
  name: "Corner House Shop",
  shortDescription: "We Sell Delicious Cookies",
  description:
      "Our Cookies are made from the best ingredients, baked to perfection, and crafted with love to bring you a delightful treat in every bite!",
  imageUrl:
      "https://drive.google.com/file/d/1uhk8r7LMELrTh5CFSI6zxwJU7zL_mKYJ/view?usp=sharing",
  // latitude: 40.7647437,
  // longitude: -73.9789166,
  address: "140 W 57th St, New York, NY 10019, USA",
);

Seller lseller = Seller(
  uid: "5ewy87DNuDWzw6f7QGSBbubDvAp1",
  name: "xx",
  email: "xx@xx.com",
  phone: "12345678",
  imageUrl:
      "https://drive.google.com/file/d/1b2eyWZy5gj7-n5Zs7wic1bJu15k7fE3D/view?usp=drivesdk",
);

class GlobalSeller extends ChangeNotifier {
  Seller? _globalSeller;

  // Getter for the global seller
  Seller? get seller => _globalSeller;

  // Ensure that we return an empty list if _globalSeller or its shops are null
  List<Shop> get shops => _globalSeller?.shops ?? [];

  // Setter for the image URL
  set imageUrl(String url) {
    if (_globalSeller == null) return;
    _globalSeller?.imageUrl = url;
    set(_globalSeller!);
  }

  // Method to set the global seller
  set(Seller seller) {
    FirestoreService.addSeller(seller);
    _globalSeller = seller;
    notifyListeners();
  }

  // Method to update the global seller
  update(Seller seller) {
    FirestoreService.updateSeller(seller);
    _globalSeller = seller;
    notifyListeners();
  }

  // Method to fetch the seller from Firestore using UID
  fetch(String uid) async {
    await FirestoreService.getSeller(uid).then((onValue) {
      _globalSeller = onValue.data();
      notifyListeners();
    });
  }

  // Method to set a shop, update if it exists, add if it doesn't
  void setShop(Shop shop) {
    if (_globalSeller == null) return; // Ensure seller exists

    // Check if the shop already exists in the seller's shop list
    int index = _globalSeller!.shops.indexWhere((s) => s.shopId == shop.shopId);

    if (index != -1) {
      // If the shop exists, update it
      _globalSeller!.shops[index] = shop;
    } else {
      // If the shop doesn't exist, add it
      _globalSeller!.shops.add(shop);
    }

    // Update the seller with the new/updated shop list
    update(_globalSeller!);
  }
}