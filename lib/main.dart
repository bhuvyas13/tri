import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'favourites_page.dart' as favourites_page;
import 'home_page.dart' as home_page;
import 'profile_page.dart';
import 'login_signup_page.dart';
import 'cart_page.dart';
import 'hotel_page.dart';
import 'models/cart_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set LoginPage as the initial route
      routes: {
        '/home': (context) => home_page.HomePage(), // HomePage route
        '/profile': (context) => ProfilePage(), // ProfilePage route
        '/favourites': (context) => favourites_page.FavouritesPage(), // FavouritesPage route
        '/cart': (context) => CartPage(), // CartPage route
        '/login': (context) => LoginPage(), // LoginPage route
        '/hotel': (context) => HotelPage(), // HotelPage route
      },
    );
  }
}
