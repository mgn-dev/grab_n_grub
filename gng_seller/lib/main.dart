import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gng_seller/services/global_seller.dart';
import 'package:gng_seller/theme.dart';
import 'package:gng_seller/views/home_screen.dart';
import 'package:gng_seller/views/welcome.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => GlobalSeller(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  getLaunchScreen() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return HomeScreen(user.uid);
    } else {
      return const Welcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sellers App',
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: getLaunchScreen(),
    );
  }
}
