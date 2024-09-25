import 'package:flutter/material.dart';
import 'package:gng_seller/model/shop.dart';


class ShopScreen extends StatelessWidget {
  final Shop shop;

  const ShopScreen({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3, // First third of the screen
              width: double.infinity,
              child: Image.network(
                shop.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            
            // Description Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.shortDescription!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    shop.description!,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            // Menu Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // To prevent ListView from taking infinite height inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
              itemCount: shop.menu.length,
              itemBuilder: (context, index) {
                final menuItem = shop.menu[index];
                return ListTile(
                  title: Text(menuItem.name!),
                  subtitle: Text(menuItem.description!),
                  trailing: Text('\$${menuItem.price!.toStringAsFixed(2)}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
