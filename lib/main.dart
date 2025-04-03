import 'package:flutter/material.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
// import 'package:project_dom/apiUtils/post_list.dart';
// import 'package:project_dom/dbUtils/item_form.dart';
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
  // runApp(FormExampleApp());
  // runApp(ApiApp());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user = User();
  String currentRoute = defaultRoute;
  String title = "Mathematics";
  MaterialAccentColor color = Colors.cyanAccent;
  DynamicSchemeVariant scheme = DynamicSchemeVariant.tonalSpot;
  Brightness brightness = Brightness.light;
  double contrastLevel = 0.0;
  SharedPreferences? prefs;
  Future<SharedPreferences> get preferences async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  void changeColor(MaterialAccentColor newColor) async {
    setState(() {
      color = newColor;
    });
    await preferences.then((prefs) => prefs.setInt('color', color.toARGB32()));
  }

  void changeScheme(DynamicSchemeVariant newScheme) async {
    setState(() {
      scheme = newScheme;
    });
    await preferences.then((prefs) => prefs.setInt('scheme', scheme.index));
  }

  void changeBrightness(Brightness newBrightness) async {
    setState(() {
      brightness = newBrightness;
    });
    await preferences
        .then((prefs) => prefs.setInt('brightness', brightness.index));
  }

  void changeContrastLevel(double newContrastLevel) async {
    setState(() {
      contrastLevel = newContrastLevel;
    });
    await preferences
        .then((prefs) => prefs.setDouble('contrastLevel', contrastLevel));
  }

  @override
  void initState() {
    super.initState();
    _loadColor(); // Call async function inside initState
    AuthService()
        .getProfileLocal()
        .then((value) => setState(() => user = value));
  }

  Future<void> _loadColor() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    preferences.then((prefs) {
      final int savedColor =
          prefs.getInt('color') ?? Colors.cyanAccent.toARGB32();
      final int savedScheme = prefs.getInt('scheme') ?? 0;
      final int savedBrightness = prefs.getInt('brightness') ?? 1;
      final double savedContrastLevel = prefs.getDouble('contrastLevel') ?? 0.0;
      setState(() {
        color = MaterialAccentColor(savedColor, const <int, Color>{});
        scheme = DynamicSchemeVariant.values[savedScheme];
        brightness = Brightness.values[savedBrightness];
        contrastLevel = savedContrastLevel;
      });
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
        page = HomeWidget(user: user);
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
        page = SettingsPage(
          changeColor: changeColor,
          changeScheme: changeScheme,
          changeBrightness: changeBrightness,
          changeContrastLevel: changeContrastLevel,
          color: color,
          scheme: scheme,
          brightness: brightness,
          contrastLevel: contrastLevel,
        );
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
    // print(currentRoute);
    return MaterialApp(
      debugShowCheckedModeBanner: showDebug,
      title: 'Project DoM',
      theme: ThemeData(
        // textTheme: TextTheme(
        //   bodyMedium: TextStyle(
        //     fontSize: 22,
        //     fontFamily: 'superC',
        //     fontWeight: FontWeight.bold,
        //   ),
        //   bodyLarge: TextStyle(
        //     fontSize: 22,
        //     fontFamily: 'superC',
        //     fontWeight: FontWeight.bold,
        //   ),
        //   bodySmall: TextStyle(
        //     fontSize: 22,
        //     fontFamily: 'superC',
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
          brightness: brightness,
          dynamicSchemeVariant: scheme,
          contrastLevel: contrastLevel,
        ),
      ),
      home: ViewEntryPoint(
        user: user,
        page: page,
        onPageChange: changePage,
        currentRoute: currentRoute,
        title: title,
        brightness: brightness,
        changeBrightness: changeBrightness,
      ),
      // routes: {
      //   '/home': (context) => const HomeWidget(),
      //   '/notice': (context) => const NoticePage(),
      //   '/attendence': (context) => const AttendencePage(),
      //   '/library': (context) => const LibraryPage(),
      //   '/assignments': (context) => const AssignmentsPage(),
      //   '/verification': (context) => const VerificationPage(),
      //   '/settings': (context) => SettingsPage(
      //         changeColor: changeColor,
      //         changeScheme: changeScheme,
      //         changeBrightness: changeBrightness,
      //         changeContrastLevel: changeContrastLevel,
      //         color: color,
      //         scheme: scheme,
      //         brightness: brightness,
      //         contrastLevel: contrastLevel,
      //       ),
      //   '/profile': (context) => const ProfilePage(),
      //   '/credits': (context) => const CreditPage(),
      // },
    );
  }
}

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

  final User user;
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
