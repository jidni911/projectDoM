import 'package:flutter/material.dart';
import 'package:project_dom/models/users.dart';

// import '../main copy.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    required this.onPageChange,
    required this.currentRoute,
    required this.user,
    super.key,
  });

  final Function(String) onPageChange;
  final String currentRoute;
  final User user;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: colorScheme.primary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: UserAccountsDrawerHeader(
                accountName: Text(
                  user.fullName ?? 'Not Logged In',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
                accountEmail: Text(
                  user.email ?? 'Click to log in',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      Image.asset('assets/bg/morning_bg.jpg').image,
                ),
              ),
              onTap: () {
                onPageChange('/profile');
                Navigator.pop(context);
              },
            ),
            DrawerListTile(
              currentRoute: currentRoute,
              onPageChange: onPageChange,
              text: 'Home',
              icon: Icons.home,
              route: '/home',
            ),
            DrawerListTile(
              currentRoute: currentRoute,
              onPageChange: onPageChange,
              text: 'Notices',
              icon: Icons.notifications,
              route: '/notice',
            ),
            DrawerListTile(
              currentRoute: currentRoute,
              onPageChange: onPageChange,
              text: 'Attendence',
              icon: Icons.check,
              route: '/attendence',
            ),
            DrawerListTile(
              currentRoute: currentRoute,
              onPageChange: onPageChange,
              text: 'Library',
              icon: Icons.book,
              route: '/library',
            ),
            DrawerListTile(
              currentRoute: currentRoute,
              onPageChange: onPageChange,
              text: 'Assignments',
              icon: Icons.assignment,
              route: '/assignments',
            ),
            ExpansionTile(
              leading: Icon(
                Icons.unfold_more_double,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'More',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: ['/settings', '/credits', '/verification']
                      .contains(currentRoute)
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Icon(
                      Icons.keyboard_double_arrow_down,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              children: [
                DrawerListTile(
                  currentRoute: currentRoute,
                  onPageChange: onPageChange,
                  text: 'Verification',
                  icon: Icons.verified,
                  route: '/verification',
                ),
                DrawerListTile(
                  currentRoute: currentRoute,
                  onPageChange: onPageChange,
                  text: 'Settings',
                  icon: Icons.settings,
                  route: '/settings',
                ),
                DrawerListTile(
                  currentRoute: currentRoute,
                  onPageChange: onPageChange,
                  text: 'Credits',
                  icon: Icons.copyright,
                  route: '/credits',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.currentRoute,
    required this.onPageChange,
    required this.text,
    required this.icon,
    required this.route,
  });

  final String currentRoute;
  final Function(String p1) onPageChange;
  final String text;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      title: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      trailing: currentRoute == route
          ? Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : null,
      onTap: () {
        onPageChange(route);
        Navigator.pop(context);
      },
    );
  }
}
