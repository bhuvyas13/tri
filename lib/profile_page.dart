import 'package:flutter/material.dart';
import 'package:tri/order_history_page.dart'; // Ensure this path is correct
import 'package:tri/about_us.dart'; // Ensure this path is correct
import 'package:tri/favourites_page.dart'; // Ensure this path is correct
import 'package:tri/home_page.dart'; // Ensure this path is correct
import 'package:tri/help_page.dart'; // Ensure this path is correct
import 'package:tri/logout_page.dart'; // Ensure this path is correct

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final int _currentIndex = 2; // Highlight Profile icon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Picture in Triangle shape
            ClipPath(
              clipper: TriangleClipper(),
              child: Image.asset(
                'assets/profile_picture.png', // Ensure to use your own image path
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bhuvya Shukla',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '+91 8628030194',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Navigation ListTiles
            ListTile(
              title: Text('Order History'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutPage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the Profile icon
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
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FavouritesPage()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 2:
              // Stay on Profile Page
              break;
          }
        },
      ),
    );
  }
}

// Triangle clipper for profile picture
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
