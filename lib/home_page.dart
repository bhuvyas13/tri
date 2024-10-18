import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for user info
import 'package:tri/cart_page.dart'; // Ensure the path to CartPage is correct
import 'package:tri/hotel_page.dart'; // Ensure the path to HotelPage is correct
import 'package:tri/favourites_page.dart' as fav_page; // Import FavouritesPage
import 'package:tri/profile_page.dart' as profile_page; // Import ProfilePage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance for user data
  int _currentIndex = 1; // Default to Home tab
  TextEditingController _searchController = TextEditingController();
  List<String> foodItems = ['Sweets', 'Chinese', 'Pizza', 'Burger', 'Pasta', 'Salad', 'Sushi'];
  List<String> filteredItems = [];

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_filterFoodItems);

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  void _filterFoodItems() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredItems = foodItems
          .where((item) => item.toLowerCase().contains(query))
          .toList(); // Filter the items based on the query
    });
  }

  void _onCardTap() {
    _animationController.forward().then((value) => _animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get the current logged-in user

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hi, ${user?.displayName ?? 'User'}', // Dynamically greet the user by name
          style: const TextStyle(
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
                MaterialPageRoute(builder: (context) => const CartPage()),
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
              // Animated Search bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Display filtered food items based on search input
              if (filteredItems.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeIn,
                      ),
                      child: ListTile(
                        title: Text(filteredItems[index]),
                        onTap: () {
                          // Navigate to HotelPage or handle search result tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HotelPage(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              else if (_searchController.text.isNotEmpty)
                const Text("No results found"), // Display no results message when search has no matches

              const SizedBox(height: 20.0),

              // Horizontal list of triangular food images (like stories)
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTriangularFoodImage('assets/food1.png'),
                    _buildTriangularFoodImage('assets/food2.png'),
                    _buildTriangularFoodImage('assets/food3.png'),
                    _buildTriangularFoodImage('assets/food4.png'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Restaurant list with animation
              _buildAnimatedRestaurantCard(
                image: 'assets/restaurant1.png',
                name: 'Ekaant',
                status: 'Open',
                time: '30-35 mins',
              ),
              const SizedBox(height: 10.0),
              _buildAnimatedRestaurantCard(
                image: 'assets/restaurant2.png',
                name: 'Antariksh',
                status: 'Closed',
                time: '50-55 mins',
              ),
              const SizedBox(height: 10.0),
              _buildAnimatedRestaurantCard(
                image: 'assets/restaurant3.png',
                name: 'Aashirwad',
                status: 'Open',
                time: '30-35 mins',
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

  // Helper method to build triangular food images with fade animation
  Widget _buildTriangularFoodImage(String assetPath) {
    return GestureDetector(
      onTap: () {
        // Show the pop-up when an image is clicked
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.orange,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            assetPath,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: FadeInImage(
        placeholder: AssetImage(assetPath), // Fade in effect for images
        image: AssetImage(assetPath),
        fadeInDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // Helper method to build animated restaurant cards
  Widget _buildAnimatedRestaurantCard({
    required String image,
    required String name,
    required String status,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
        _onCardTap();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HotelPage()),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: RestaurantCard(
          image: image,
          name: name,
          status: status,
          time: time,
        ),
      ),
    );
  }
}

// Custom clipper for triangle shape
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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
