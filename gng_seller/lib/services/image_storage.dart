import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorage {
  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  static Future<String?> uploadImageToFirebase(XFile imageFile) async {
    try {
      // Create a reference to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Set a unique path for the file in the storage
      String fileName =
          'uploads/${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      Reference ref = storage.ref().child(fileName);

      // Upload the file
      UploadTask uploadTask = ref.putFile(File(imageFile.path));

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl; // Return the file's download URL
    } catch (e) {
      return null;
    }
  }

  static Future<String?> pickAndUploadImage() async {
    // Pick an image
    XFile? imageFile = await pickImage();

    if (imageFile != null) {
      // Upload the image to Firebase Storage
      String? downloadUrl = await uploadImageToFirebase(imageFile);

      if (downloadUrl != null) {
        print('Image uploaded successfully: $downloadUrl');
        return downloadUrl;
      }
    }
    return null;
  }
}
