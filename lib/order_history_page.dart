import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            OrderCard(
              image: 'assets/chocolate_cake.png',
              title: 'Chocolate Cake',
              price: '₹500',
              date: 'Today',
            ),
            OrderCard(
              image: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              date: 'Yesterday',
            ),
            OrderCard(
              image: 'assets/red_sauce_pasta.png',
              title: 'Red Sauce Pasta',
              price: '₹180',
              date: '03.09.24',
            ),
            OrderCard(
              image: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              date: '04.09.24',
            ),
            OrderCard(
              image: 'assets/chocolate_cake.png',
              title: 'Chocolate Cake',
              price: '₹500',
              date: '05.09.24',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String date;

  const OrderCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Add action when more button is clicked
          },
        ),
      ),
    );
  }
}
