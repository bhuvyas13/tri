import 'package:flutter/material.dart';
import 'package:tri/cart_page.dart';
import 'package:tri/hotel_page.dart'; // Import the HotelPage
import 'package:tri/favourites_page.dart' as fav_page; // Import FavouritesPage
import 'package:tri/profile_page.dart' as profile_page; // Import the ProfilePage class

// HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

// HomePage state class
class HomePageState extends State<HomePage> {
  int _currentIndex = 1; // Default to Home tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Hi, Bhuvya',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Navigate to CartPage when the cart button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Horizontal list of food images
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFoodImage('assets/food1.png'),
                    _buildFoodImage('assets/food2.png'),
                    _buildFoodImage('assets/food3.png'),
                    _buildFoodImage('assets/food4.png'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Restaurant list
              GestureDetector(
                onTap: () {
                  // Navigate to HotelPage when this restaurant is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelPage(), // Pass data if needed
                    ),
                  );
                },
                child: const RestaurantCard(
                  image: 'assets/restaurant1.png',
                  name: 'Ekaant',
                  status: 'Open',
                  time: '30-35 mins',
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  // Navigate to HotelPage when this restaurant is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelPage(), // Pass data if needed
                    ),
                  );
                },
                child: const RestaurantCard(
                  image: 'assets/restaurant2.png',
                  name: 'Antariksh',
                  status: 'Closed',
                  time: '50-55 mins',
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  // Navigate to HotelPage when this restaurant is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelPage(), // Pass data if needed
                    ),
                  );
                },
                child: const RestaurantCard(
                  image: 'assets/restaurant3.png',
                  name: 'Aashirwad',
                  status: 'Open',
                  time: '30-35 mins',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set currentIndex to highlight Home
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update currentIndex
          });

          // Navigate based on bottom bar index
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => fav_page.FavouritesPage()),
            );
          } else if (index == 1) {
            // Stay on Home page
          } else if (index == 2) {
            // Navigate to Profile page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => profile_page.ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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
      ),
    );
  }

  // Helper method to build food images
  Widget _buildFoodImage(String assetPath) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          assetPath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Restaurant card widget
class RestaurantCard extends StatelessWidget {
  final String image;
  final String name;
  final String status;
  final String time;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: status == 'Open' ? Colors.green : Colors.red,
                ),
              ),
              Text(time, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
