import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Dmitry'),
          accountEmail: Text('dmitry@me.com'),
          currentAccountPicture: CircleAvatar(
            backgroundImage: Image.asset('assets/bg/morning_bg.jpg').image,
          ),
        ),
      ],
    ));
  }
}
