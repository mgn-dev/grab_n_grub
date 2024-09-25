import 'package:flutter/material.dart';
import 'package:gng_seller/model/shop.dart';
import 'package:gng_seller/services/global_seller.dart';
import 'package:gng_seller/services/image_storage.dart';
import 'package:gng_seller/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image; // Holds the selected image file
  String _name = '';
  String _shortDescription = '';
  String _description = '';
  String? _imageUrl = ''; // Will hold the Firebase image URL
  String _address = ''; // Manually input address

  double spaceBetween = 20;

  // Function to pick an image using ImagePicker
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile; // Update the image state immediately
      });

      // Upload the image to Firebase and get the URL
      String? imageUrl = await ImageStorage.uploadImageToFirebase(pickedFile);

      // Ensure the imageUrl is set after a successful upload
      if (imageUrl != null && imageUrl.isNotEmpty) {
        setState(() {
          _imageUrl = imageUrl; // Update the state with the Firebase URL
        });
      }
    }
  }

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Proceed if the image URL is available
      if (_imageUrl != null && _imageUrl!.isNotEmpty) {
        // Create Shop object with the image URL
        Shop newShop = Shop(
          shopId: uuid.v4(),
          sellerId:
              Provider.of<GlobalSeller>(context, listen: false).seller!.uid,
          name: _name,
          shortDescription: _shortDescription,
          description: _description,
          imageUrl: _imageUrl, // Store the image URL from Firebase
          address: _address,
        );

        // Store the new shop in the provider or your database
        Provider.of<GlobalSeller>(context, listen: false).setShop(newShop);

        // Go back to home screen or shop list
        Navigator.pop(context);
      } else {
        // Show a SnackBar to inform the user that image upload is still required
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select and upload an image.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image picker section
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? const Center(child: Text('Tap to select image'))
                      : Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: spaceBetween),

              // Name field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Shop Name'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shop name';
                  }
                  return null;
                },
              ),
              SizedBox(height: spaceBetween),

              // Short description field
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Short Description'),
                onSaved: (value) {
                  _shortDescription = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a short description';
                  }
                  return null;
                },
              ),
              SizedBox(height: spaceBetween),

              // Full description field
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Full Description'),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: spaceBetween),

              // Address field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  _address = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: spaceBetween),

              // Custom Button to submit form
              CustomButton(
                function: _submitForm,
                text: 'Create Shop',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
