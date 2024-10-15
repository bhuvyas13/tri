import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for logout
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    // Perform Firebase sign out
    await FirebaseAuth.instance.signOut();

    // Navigate to the LogoutPage after signing out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogoutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get current logged-in user

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
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
            const SizedBox(height: 10),
            Text(
              user?.displayName ?? 'User', // Display user's name if available
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user?.phoneNumber ?? 'No Phone Number', // Display phone number if available
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Navigation ListTiles
            ListTile(
              title: const Text('Order History'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: _confirmLogout, // Call the confirmation dialog
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
                MaterialPageRoute(builder: (context) => const FavouritesPage()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
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
