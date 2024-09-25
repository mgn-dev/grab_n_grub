import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gng_seller/model/seller.dart';

class FirestoreService {
  static final ref = FirebaseFirestore.instance
      .collection('sellers')
      .withConverter(
          fromFirestore: Seller.fromFireStore,
          toFirestore: (Seller seller, _) => seller.toFireStore());

  // Add a new seller
  static Future<void> addSeller(Seller seller) async {
    await ref.doc(seller.uid).set(seller);
  }

  // Get a single seller by uid
  static Future<DocumentSnapshot<Seller>> getSeller(String uid) async {
    return await ref.doc(uid).get();
  }

  // Update a seller
  static Future<void> updateSeller(Seller seller) async {
    // Call update and pass the seller's toFireStore() map
    await ref.doc(seller.uid).update(seller.toFireStore());
  }

  // Delete a seller by uid
  static Future<void> deleteSeller(Seller seller) async {
    await ref.doc(seller.uid).delete();
  }
}
