import 'package:flutter/material.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AuthService authService = AuthService();

  User user = User();

  @override
  void initState() {
    super.initState();
    authService.getProfileLocal().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 50,
            ),
            SizedBox(height: 20),
            Text('This is Page 3', style: TextStyle(fontSize: 20)),
            Text(user.fullName ?? '', style: TextStyle(fontSize: 20)),
            Text(user.email ?? '', style: TextStyle(fontSize: 20)),
            Text(user.username ?? '', style: TextStyle(fontSize: 20)),
            if (user.id != null)
              ElevatedButton.icon(
                onPressed: () async {
                  await authService.logout();
                  setState(() {
                    user = User();
                  });
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              )
          ],
        ),
      ),
    );
  }
}
