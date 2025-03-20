import 'package:flutter/material.dart';
import 'package:project_dom/setup.dart';
import 'package:project_dom/ui/app_bar_widget.dart';
import 'package:project_dom/ui/assignments/assignments.dart';
import 'package:project_dom/ui/attendence/attendence.dart';
import 'package:project_dom/ui/credits/credits.dart';
import 'package:project_dom/ui/drawer_widget.dart';
import 'package:project_dom/ui/home/home_widget.dart';
import 'package:project_dom/ui/library/library.dart';
import 'package:project_dom/ui/notice/notice.dart';
import 'package:project_dom/ui/settings/settings.dart';
import 'package:project_dom/ui/verification/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/profile/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String currentRoute = '/home';
  String title = "Mathematics";
  MaterialAccentColor color = Colors.cyanAccent;
  // MaterialAccentColor color = ;

  void changeColor(MaterialAccentColor newColor) async {
    setState(() {
      color = newColor;
    });
    _saveColor();
  }

  Future<void> _saveColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('color', color.toARGB32());
  }

  @override
  void initState() {
    super.initState();
    _loadColor(); // Call async function inside initState
  }

  Future<void> _loadColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColor = prefs.getInt('color') ?? Colors.cyanAccent.toARGB32();
    setState(() {
      color = MaterialAccentColor(savedColor, const <int, Color>{});
    });
  }

  // Function to update the page
  void changePage(String newRoute) {
    setState(() {
      currentRoute = newRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentRoute) {
      case '/home':
        page = const HomeWidget();
        title = "Mathematics";
      case '/notice':
        page = const NoticePage();
        title = "Notice";
      case '/attendence':
        page = const AttendencePage();
        title = "Attendence";
      case '/library':
        page = const LibraryPage();
        title = "Library";
      case '/assignments':
        page = const AssignmentsPage();
        title = "Assignments";
      case '/verification':
        page = const VerificationPage();
        title = "Verification";
      case '/settings':
        page = SettingsPage(changeColor: changeColor);
        title = "Settings";
      case '/profile':
        page = const ProfilePage();
        title = "Profile";
      case '/credits':
        page = const CreditPage();
        title = "Credits";
      default:
        throw UnimplementedError('no widget for $currentRoute');
    }
    return MaterialApp(
      debugShowCheckedModeBanner: showDebug,
      title: 'Project DoM',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        // primaryColor: Colors.blue,
      ),
      home: ViewEntryPoint(
        page: page,
        onPageChange: changePage,
        currentRoute: currentRoute,
        title: title,
      ),
      routes: {
        '/home': (context) => const HomeWidget(),
        '/notice': (context) => const NoticePage(),
        '/attendence': (context) => const AttendencePage(),
        '/library': (context) => const LibraryPage(),
        '/assignments': (context) => const AssignmentsPage(),
        '/verification': (context) => const VerificationPage(),
        '/settings': (context) => SettingsPage(changeColor: changeColor),
        '/profile': (context) => const ProfilePage(),
        '/credits': (context) => const CreditPage(),
      },
    );
  }
}

class ViewEntryPoint extends StatelessWidget {
  const ViewEntryPoint({
    required this.page,
    required this.onPageChange,
    required this.currentRoute,
    required this.title,
    super.key,
  });

  final Widget page;
  final Function(String) onPageChange;
  final String currentRoute;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: title,
      ),
      body: page,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 0,
        child: Text("Under Construction"),
      ),
      drawer: DrawerWidget(
        onPageChange: onPageChange,
        currentRoute: currentRoute,
      ),
      endDrawer: DrawerWidget(
        onPageChange: onPageChange,
        currentRoute: currentRoute,
      ),
      endDrawerEnableOpenDragGesture: true,
      drawerEnableOpenDragGesture: true,
    );
  }
}
