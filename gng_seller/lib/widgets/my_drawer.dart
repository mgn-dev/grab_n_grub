import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gng_seller/main.dart';
import 'package:gng_seller/services/auth_service.dart';
import 'package:gng_seller/services/global_seller.dart';
import 'package:gng_seller/services/image_storage.dart';
import 'package:gng_seller/views/welcome.dart';
import 'package:gng_seller/widgets/color_palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? _localProfileImageUrl; // Store locally picked image URL
  // String? _imageUrl = '';
  XFile? _image;

  @override
  void initState() {
    super.initState();
    // Initialize with the seller's image URL from the provider (if available)
    _localProfileImageUrl = Provider.of<GlobalSeller>(context, listen: false).seller?.imageUrl;
  }

  // Function to pick an image using ImagePicker
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile; // Update the image state immediately
      });

      // Upload the image to Firebase and get the URL
      String? imageUrl = await ImageStorage.uploadImageToFirebase(pickedFile);

      // Ensure the imageUrl is set after a successful upload
      if (imageUrl != null && imageUrl.isNotEmpty) {
        setState(() {
          _localProfileImageUrl = imageUrl; // Update the state with the Firebase URL
        });
        Provider.of<GlobalSeller>(context, listen: false).imageUrl = imageUrl;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalSeller>(
      builder: (context, globalSeller, child) {
        // Use locally picked image URL if available, otherwise fallback to seller's stored imageUrl
        String profileImageUrl = _localProfileImageUrl ?? globalSeller.seller?.imageUrl ?? '';

        return Drawer(
          child: ListView(
            children: [
              // Drawer header
              Container(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 120,
                        width: 120, // Make width equal to height for a perfect circle
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        clipBehavior: Clip.antiAlias, // Clips the child to the circular shape
                        child: _image != null
                            ? Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover, // Ensures the file image fills the circular space
                              )
                            : profileImageUrl.isNotEmpty
                                ? Image.network(
                                    profileImageUrl,
                                    fit: BoxFit.cover, // Ensures the network image fills the circular space
                                  )
                                : Image.asset(
                                    'images/default_profile.png',
                                    fit: BoxFit.cover, // Fallback to default profile image
                                  ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      globalSeller.seller?.name ?? 'Guest',
                      style: const TextStyle(
                          color: Colors.black, fontSize: 20, fontFamily: "Train"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Drawer body with menu items
              Container(
                padding: const EdgeInsets.only(top: 1.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.access_alarms_sharp, color: ColorPalette.iconColor),
                      title: const Text("Current Orders", style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => const MyApp()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.monetization_on_outlined, color: ColorPalette.iconColor),
                      title: const Text("New Orders", style: TextStyle(color: Colors.black)),
                      onTap: () {
                        // Add your logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.check_box_outlined, color: ColorPalette.iconColor),
                      title: const Text("History Orders", style: TextStyle(color: Colors.black)),
                      onTap: () {
                        // Add your logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: ColorPalette.iconColor),
                      title: const Text("Sign Out", style: TextStyle(color: Colors.black)),
                      onTap: () {
                        AuthService.signOut().then((value) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (c) => const Welcome()));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
