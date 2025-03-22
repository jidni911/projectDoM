import 'package:flutter/material.dart';

// import '../main copy.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    required this.onPageChange,
    required this.currentRoute,
    super.key,
  });

  final Function(String) onPageChange;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: UserAccountsDrawerHeader(
                accountName: Text('Dmitry'),
                accountEmail: Text('dmitry@me.com'),
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
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Home',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/home'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/home');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Notices',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/notice'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/notice');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Attendence',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/attendence'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/attendence');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Library',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/library'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/library');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.assignment,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Assignments',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/assignments'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/assignments');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.verified,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Verification',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/verification'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/verification');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Settings',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/settings'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/settings');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.copyright,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                'Credits',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              trailing: currentRoute == '/credits'
                  ? Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : null,
              onTap: () {
                onPageChange('/credits');
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  'About',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                trailing: currentRoute == '/about'
                    ? Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : null,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/home'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/home');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Notices',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/notice'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/notice');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Attendence',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/attendence'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/attendence');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Library',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/library'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/library');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Assignments',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/assignments'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/assignments');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.verified,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Verification',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/verification'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/verification');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/settings'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/settings');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.copyright,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      'Credits',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: currentRoute == '/credits'
                        ? Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    onTap: () {
                      onPageChange('/credits');
                      Navigator.pop(context);
                    },
                  ),
                ],)
          ],
        ),
      ),
    );
  }
}
