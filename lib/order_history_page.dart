import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton( // Adding a back button
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page (Profile Page)
          },
        ),
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
          children: [
            OrderCard(
              image: 'assets/chocolate_cake.png',
              title: 'Chocolate Cake',
              price: '₹500',
              orderDate: DateTime.now(), // Today
            ),
            OrderCard(
              image: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              orderDate: DateTime.now().subtract(const Duration(days: 1)), // Yesterday
            ),
            OrderCard(
              image: 'assets/red_sauce_pasta.png',
              title: 'Red Sauce Pasta',
              price: '₹180',
              orderDate: DateTime(2024, 9, 3), // Specific date
            ),
            OrderCard(
              image: 'assets/chicken_tikka.png',
              title: 'Chicken Tikka',
              price: '₹260',
              orderDate: DateTime(2024, 9, 4),
            ),
            OrderCard(
              image: 'assets/chocolate_cake.png',
              title: 'Chocolate Cake',
              price: '₹500',
              orderDate: DateTime(2024, 9, 5),
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
  final DateTime orderDate;

  const OrderCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.orderDate,
  });

  // Function to format the order date as "Today," "Yesterday," or a specific date
  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd.MM.yy').format(date);
    }
  }

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align title and date on opposite sides
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              getFormattedDate(orderDate),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        subtitle: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
