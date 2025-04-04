import 'package:flutter/material.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/ui/app_bar_widget.dart';
import 'package:project_dom/ui/drawer_widget.dart';

class ViewEntryPoint extends StatelessWidget {
  const ViewEntryPoint({
    required this.user,
    required this.page,
    required this.onPageChange,
    required this.currentRoute,
    required this.title,
    required this.brightness,
    required this.changeBrightness,
    super.key,
  });

  final User? user;
  final Widget page;
  final Function(String) onPageChange;
  final String currentRoute;
  final String title;
  final Brightness brightness;
  final Function(Brightness) changeBrightness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBarWidget(
        title: title,
        onPageChange: onPageChange,
        currentRoute: currentRoute,
        brightness: brightness,
        changeBrightness: changeBrightness,
      ),
      body: page,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomAppBar(
        height: 0,
        child: Text("Under Construction"),
      ),
      drawer: DrawerWidget(
        onPageChange: onPageChange,
        currentRoute: currentRoute,
        user: user,
      ),
      endDrawer: DrawerWidget(
        onPageChange: onPageChange,
        currentRoute: currentRoute,
        user: user,
      ),
      endDrawerEnableOpenDragGesture: true,
      drawerEnableOpenDragGesture: true,
    );
  }
}
