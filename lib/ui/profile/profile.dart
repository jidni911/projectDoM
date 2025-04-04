import 'package:flutter/material.dart';
import 'package:project_dom/ui/profile/login_form.dart';
import 'package:project_dom/ui/profile/profile_view.dart';
import 'package:project_dom/ui/profile/registration_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.refreshUser, super.key});

  final Function refreshUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController for 3 tabs
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Registration"),
            Tab(text: "Log in"),
            Tab(text: "Profile"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Page 1
              RegistrationForm(),
              // Page 2
              LoginFormWidget(refreshUser: widget.refreshUser),
              // Page 3
              ProfileView(refreshUser: widget.refreshUser),
            ],
          ),
        ),
      ],
    );
  }
}
