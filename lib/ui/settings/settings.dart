import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.changeColor, super.key});

  final Function(MaterialAccentColor) changeColor;

  @override
  Widget build(BuildContext context) {
    // List<MaterialAccentColor> colors = Colors.accents;
    List<MapEntry<MaterialAccentColor, String>> colors = [
      MapEntry(Colors.amberAccent, 'Amber'),
      MapEntry(Colors.blueAccent, 'Blue'),
      MapEntry(Colors.cyanAccent, 'Cyan'),
      MapEntry(Colors.deepOrangeAccent, 'Deep Orange'),
      MapEntry(Colors.deepPurpleAccent, 'Deep Purple'),
      MapEntry(Colors.greenAccent, 'Green'),
      MapEntry(Colors.indigoAccent, 'Indigo'),
      MapEntry(Colors.lightBlueAccent, 'Light Blue'),
      MapEntry(Colors.lightGreenAccent, 'Light Green'),
      MapEntry(Colors.limeAccent, 'Lime'),
      MapEntry(Colors.orangeAccent, 'Orange'),
      MapEntry(Colors.pinkAccent, 'Pink'),
      MapEntry(Colors.purpleAccent, 'Purple'),
      MapEntry(Colors.redAccent, 'Red'),
      MapEntry(Colors.tealAccent, 'Teal'),
      MapEntry(Colors.yellowAccent, 'Yellow'),

      // Colors.amber,
    ];
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.surface,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(''),
          ),
        ),
      ),
      Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 200,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 200,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Theme',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
              children: [
                for (var color in colors)
                  ThemeButton(
                    color: color,
                    changeColor: changeColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    required this.color,
    required this.changeColor,
    super.key,
  });

  final MapEntry<MaterialAccentColor, String> color;

  final Function(MaterialAccentColor) changeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5).copyWith(),
      child: ElevatedButton(
        onPressed: () {
          changeColor(color.key);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color.key),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 10, vertical: 40)),
        ),
        child: Text(
          color.value,
          style: TextStyle(
              color: ThemeData.from(
                      colorScheme: ColorScheme.fromSeed(seedColor: color.key))
                  .colorScheme
                  .onPrimary),
        ),
      ),
    );
  }
}
