import 'package:flutter/material.dart';
import 'package:tri/home_page.dart' as home_page; // Import HomePage
import 'package:tri/profile_page.dart'; // Import ProfilePage
import 'share_popup.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Override the back button behavior to navigate to the HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const home_page.HomePage()),
        );
        // Return false to prevent the default pop behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            FavouriteItem(
              imageUrl: 'assets/chocolate_cake.png',
              title: 'Chocolate Cake',
              price: '₹500',
              isVeg: true,
            ),
            FavouriteItem(
              imageUrl: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              isVeg: false,
            ),
            FavouriteItem(
              imageUrl: 'assets/red_sauce_pasta.png',
              title: 'Red Sauce Pasta',
              price: '₹180',
              isVeg: true,
            ),
            FavouriteItem(
              imageUrl: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              isVeg: false,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // Highlight the current tab (Favorites)
          onTap: (int index) {
            // Handle navigation based on the index
            switch (index) {
              case 0:
                // Already on the Favourites page, no need to navigate.
                break;
              case 1:
                // Navigate to Home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const home_page.HomePage()),
                );
                break;
              case 2:
                // Navigate to Profile page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                break;
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
      ),
    );
  }
}

class FavouriteItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final bool isVeg;

  const FavouriteItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.isVeg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for proper layout
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Food Details (Name, Price, Veg/Non-Veg Icon)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                // Veg/Non-Veg Icon
                Row(
                  children: [
                    Icon(
                      isVeg ? Icons.check_box_outline_blank : Icons.stop_circle,
                      color: isVeg ? Colors.green : Colors.red,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Share Button for each item
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Open Share popup when clicked
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SharePopup();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
