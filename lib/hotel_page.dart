import 'package:flutter/material.dart';
import 'package:tri/cart_page.dart';
import 'package:tri/favourites_page.dart' as fav_page; // Import FavouritesPage
import 'package:tri/profile_page.dart'; // Import ProfilePage

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  HotelPageState createState() => HotelPageState();
}

class HotelPageState extends State<HotelPage> {
  final int _currentIndex = 1; // Set to 1 for Home, indicating current page

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => fav_page.FavouritesPage()),
        );
        break;
      case 1:
        // Stay on Hotel Page
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10), // Space between search and cart
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/restaurant1.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                HotelMenuItem(
                  imageUrl: 'assets/red_sauce_pasta.png',
                  name: 'Red Sauce Pasta',
                  price: '₹180',
                  likes: '123',
                ),
                HotelMenuItem(
                  imageUrl: 'assets/chicken_tikka.png',
                  name: 'Chicken Tikka',
                  price: '₹260',
                  likes: '18',
                ),
                HotelMenuItem(
                  imageUrl: 'assets/chocolate_cake.png',
                  name: 'Chocolate Cake',
                  price: '₹500',
                  likes: '250',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set currentIndex to 1
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped, // Use the function to handle taps
      ),
    );
  }
}

// HotelMenuItem class with quantity buttons
class HotelMenuItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String likes;

  const HotelMenuItem({super.key, 
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.likes,
  });

  @override
  HotelMenuItemState createState() => HotelMenuItemState();
}

class HotelMenuItemState extends State<HotelMenuItem> {
  int _quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.price,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (_quantity > 1) {
                      _quantity--; // Decrease quantity
                    }
                  });
                },
              ),
              Text('$_quantity'), // Display current quantity
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _quantity++; // Increase quantity
                  });
                },
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            children: [
              Icon(Icons.favorite, color: Colors.red),
              Text(widget.likes),
            ],
          ),
        ],
      ),
    );
  }
}
