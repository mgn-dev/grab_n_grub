
import 'package:flutter/material.dart';
import 'package:gng_seller/services/global_seller.dart';
import 'package:gng_seller/views/create_shop.dart';
import 'package:gng_seller/widgets/my_drawer.dart';
import 'package:gng_seller/widgets/shop_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.uid, {super.key});

  final String? uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    if (widget.uid != null) {
      Provider.of<GlobalSeller>(context, listen: false).fetch(widget.uid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalSeller>(builder: (context, value, child) {
      // Check if the value (GlobalSeller) or its properties (e.g., shops) are null
      if (value.shops.isEmpty) {
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: Text(
              value.seller?.name != null ? value.seller!.name : 'Guests Shop', // Fallback to 'Guest' if seller is null
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const CreateShop(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: const Center(
            child: Text('No shops available.'),
          ),
        );
      }

      // If everything is loaded properly, display the list of shops
      return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            value.seller?.name ?? 'Guest', // Fallback to 'Guest' if seller is null
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const CreateShop(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(14),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // List of shops
              Expanded(
                child: ListView.builder(
                  itemCount: value.shops.length,
                  itemBuilder: (_, index) {
                    return ShopCard(value.shops[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
