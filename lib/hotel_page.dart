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
                margin: const EdgeInsets.only(right: 10), // Space between search and cart
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
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
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
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
                  initialLikes: 123, // Pass initial likes as int
                ),
                HotelMenuItem(
                  imageUrl: 'assets/chicken_tikka.png',
                  name: 'Chicken Tikka',
                  price: '₹260',
                  initialLikes: 18,
                ),
                HotelMenuItem(
                  imageUrl: 'assets/chocolate_cake.png',
                  name: 'Chocolate Cake',
                  price: '₹500',
                  initialLikes: 250,
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

// HotelMenuItem class with corrected button sizes and alignment
class HotelMenuItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final int initialLikes;

  const HotelMenuItem({
    super.key, 
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.initialLikes,
  });

  @override
  HotelMenuItemState createState() => HotelMenuItemState();
}

class HotelMenuItemState extends State<HotelMenuItem> {
  int _quantity = 1; // Default quantity
  bool _isLiked = false; // Track like state
  late int _likes; // Track number of likes

  @override
  void initState() {
    super.initState();
    _likes = widget.initialLikes; // Initialize likes with the passed value
  }

  // Method to toggle like status
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked; // Toggle the liked state
      _isLiked ? _likes++ : _likes--; // Increase or decrease like count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
        children: [
          // Stack to position the image and the buttons
          Stack(
            children: [
              // Dish image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned Row for quantity control buttons (+ and -) overlapping the image
              Positioned(
                bottom: -10, // Adjusted positioning for better alignment
                left: 5, // Align it better under the image
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green, // Background color of the buttons
                    borderRadius: BorderRadius.circular(5), // Adjusted for smaller corner radius
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 0.2, vertical: 0.4), // Reduced padding for smaller size
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 8, // Further reduced icon size
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) {
                              _quantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(color: Colors.white, fontSize: 12), // Reduced font size for quantity text
                      ),
                      IconButton(
                        iconSize: 10, // Further reduced icon size
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Name and Price (Expanded column)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Corrected font size for price
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Like button and count
          Column(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleLike, // Toggle like state on button press
              ),
              Text('$_likes'), // Display the updated like count
            ],
          ),
        ],
      ),
    );
  }
}
