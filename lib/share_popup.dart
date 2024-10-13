import 'package:flutter/material.dart';

class SharePopup extends StatelessWidget {
  const SharePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share Order'),
      content: const Text('Share your favorite order with friends!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
