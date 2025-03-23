import 'package:flutter/material.dart';

class CreditPage extends StatelessWidget {
  const CreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorSceme = Theme.of(context).colorScheme;
    return Column(children: [
      Container(
        color: colorSceme.surface,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Credits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: colorSceme.onSurface,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
          children: [
            Text("ok"),
            Text("ok"),
            Text("ok"),
          ],
        ),
      )
    ]);
  }
}
