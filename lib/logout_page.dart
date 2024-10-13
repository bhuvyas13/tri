import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Out'),
      ),
      body: Center(
        child: Text('You have been logged out.'),
      ),
    );
  }
}
