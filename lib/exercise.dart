import 'package:flutter/material.dart';

class Exercise extends StatefulWidget {
  final int nSets;
  final int nReps;
  final double weight;

  const Exercise({super.key, required this.nSets, required this.nReps, required this.weight});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },
            children: sets(widget.nSets, widget.weight, widget.nReps),
          ),
        ],
      ),
    );
  }
}

List<TableRow> sets (int nSets, double weight, int nReps) {
  List<TableRow> sets = [TableRow(
    children: [
      Text("Set"),
      Text("Weight"),
      Text("Reps"),
    ]
  )];
  for (int i = 1; i < nSets+1; i++) {
    sets.add(
      TableRow(
        children: [
          Text("$i"),
          Text("$weight kg"),
          Text("$nReps"),
        ]
      )
    );
  }
  return sets;
}