import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage(
      {required this.changeColor,
      required this.changeScheme,
      required this.changeBrightness,
      required this.changeContrastLevel,
      required this.color,
      required this.scheme,
      required this.brightness,
      required this.contrastLevel,
      super.key});

  final Function(MaterialAccentColor) changeColor;
  final Function(DynamicSchemeVariant) changeScheme;
  final Function(Brightness) changeBrightness;
  final Function(double) changeContrastLevel;
  final MaterialAccentColor color;
  final DynamicSchemeVariant scheme;
  final Brightness brightness;
  final double contrastLevel;

  @override
  Widget build(BuildContext context) {
    // double sliderValue = 0.0;
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
    ];

    List<String> schemes =
        DynamicSchemeVariant.values.map((e) => e.name).toList();

    List<String> brightnesses = Brightness.values.map((e) => e.name).toList();

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
                    'Theme Colors ()', //TODO
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
                  maxCrossAxisExtent: 200, childAspectRatio: 200 / 80),
              children: [
                for (var c in colors)
                  ThemeColorButton(
                    color: c,
                    changeColor: changeColor,
                    currentColor: color,
                  ),
              ],
            ),
          ),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 300,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Theme Schemes (${scheme.name})',
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
                  maxCrossAxisExtent: 200, childAspectRatio: 200 / 80),
              children: [
                for (var s in schemes)
                  ElevatedButton(
                    onPressed: () {
                      changeScheme(DynamicSchemeVariant.values
                          .firstWhere((element) => element.name == s));
                    },
                    // style: ButtonStyle(
                    //   backgroundColor: WidgetStateProperty.all(
                    //       DynamicSchemeVariant.values
                    //           .firstWhere((element) => element.name == scheme)
                    //           .color),
                    //   padding: WidgetStateProperty.all(
                    //       EdgeInsets.symmetric(horizontal: 10, vertical: 40)),
                    // ),
                    child: Text(
                      s + (scheme.name == s ? '✔️' : ''),
                      // style: TextStyle(
                      //   color: ThemeData.from(
                      //           colorScheme: ColorScheme.fromSeed(
                      //               seedColor: DynamicSchemeVariant.values
                      //                   .firstWhere(
                      //                       (element) => element.name == scheme)
                      //                   .color))
                      //       .colorScheme
                      //       .onPrimary,
                      // ),
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 300,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Theme Brightness (${brightness.name})',
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
                for (var b in brightnesses)
                  ElevatedButton(
                    onPressed: () {
                      changeBrightness(Brightness.values
                          .firstWhere((element) => element.name == b));
                    },
                    child: Text(b + (brightness.name == b ? '✔️' : '')),
                  ),
              ],
            ),
          ),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 200,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Theme Contrast Level (${contrastLevel.toStringAsFixed(2)})',
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
            child: Slider(
                value: contrastLevel,
                onChanged: (value) {
                  changeContrastLevel(value);
                  // sliderValue = value;
                }),
          ),
        ],
      ),
    ]);
  }
}

class ThemeColorButton extends StatelessWidget {
  const ThemeColorButton({
    required this.color,
    required this.changeColor,
    required this.currentColor,
    super.key,
  });

  final MapEntry<MaterialAccentColor, String> color;

  final Function(MaterialAccentColor) changeColor;

  final MaterialAccentColor currentColor;

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
        ),
        child: Text(
          "${color.value} ${color.key == currentColor ? "✔️" : ""}",
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
