import 'package:flutter/material.dart';
import 'package:project_dom/ui/attendence/attendence.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AttendencePageState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final student = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleAttendence(student);
                },
                icon: appState.attended.contains(student)
                    ? Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        size: 12,
                        color: Colors.red,
                      ),
                label: Text(
                  '${student.classRoll} - ${student.name}',
                  style: TextStyle(
                    color: appState.attended.contains(student)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
