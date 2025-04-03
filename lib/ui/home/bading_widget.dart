import 'package:flutter/material.dart';

class BadingTextWidget extends StatelessWidget {
  const BadingTextWidget({
    required this.badingText,
    super.key,
  });

  final String badingText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom: 50),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ), // Adjust padding for shape
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50), // Ensures pill shape
        ),
        child: Text(
          badingText,
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
