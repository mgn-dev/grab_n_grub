import 'package:flutter/material.dart';
import 'package:gng_seller/model/shop.dart';
import 'package:gng_seller/widgets/custom_text.dart';

class ShopCard extends StatelessWidget {
  const ShopCard(
    this.shop, {
    super.key,
    this.imageLoc,
    this.shopName,
    this.shopStatus,
  });

  final Shop? shop;

  final String? imageLoc;
  final String? shopName;
  final String? shopStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Column(
        children: [
          Container(
            width: double.infinity, // Ensures the image takes up the full width of the card
            height: 200, // Adjust height based on your design
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0), // Match the card's border radius
                topRight: Radius.circular(15.0),
              ),
              image: DecorationImage(
                // Use NetworkImage to load the image from a URL
                image: NetworkImage(shop!.imageUrl!),
                fit: BoxFit.cover, // Ensures the image covers the container while maintaining aspect ratio
                onError: (error, stackTrace) {
                  // If image fails to load, you can handle it here
                  print('Failed to load image: $error');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: shop!.name ?? 'No Shop Name', // Safely handle null values
                  style: StyledText.labelHeavyDark.style,
                ),
                CustomText(
                  text: shopStatus ?? 'Open', // Use shopStatus or fallback to default
                  style: StyledText.labelLightDark.style,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
