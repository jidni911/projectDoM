// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.title,
    required this.onPageChange,
    required this.currentRoute,
    required this.brightness,
    required this.changeBrightness,
    Key? key,
  });

  final String title;
  final String currentRoute;
  final Function(String) onPageChange;
  final Brightness brightness;
  final Function(Brightness) changeBrightness;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(brightness == Brightness.light
              ? Icons.light_mode
              : Icons.dark_mode),
          color: Theme.of(context).colorScheme.onPrimary,
          // iconSize: 50,
          onPressed: () {
            changeBrightness(brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light);
          },
        ),
        if (currentRoute != '/settings')
          IconButton(
            onPressed: () {
              onPageChange('/settings');
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onPrimary),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
