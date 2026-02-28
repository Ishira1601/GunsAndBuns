import 'package:flutter/material.dart';
import 'exercise.dart';

class Workout extends StatefulWidget {
  const Workout({
    super.key,
    this.currentDay = 1,
    this.exercises = const [],
    this.onExercisesChanged,
  });

  final int currentDay;
  final List<ExerciseData> exercises;
  final void Function(List<ExerciseData>)? onExercisesChanged;

  @override
  State<Workout> createState() => WorkoutState();
}

class WorkoutState extends State<Workout> {
  late List<ExerciseData> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.exercises);
  }

  @override
  void didUpdateWidget(Workout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercises != widget.exercises) {
      _exercises = List.from(widget.exercises);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Workout Day ${widget.currentDay}"),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your workout:'),
              const SizedBox(height: 8),
              if (_exercises.isEmpty)
                const Text('No exercises yet.')
              else
                ..._exercises.map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Exercise(nSets: e.sets, nReps: e.reps, weight: e.weight),
                        const SizedBox(height: 12),
                      ],
                    )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addExercise(),
        tooltip: 'Add Exercise',
        child: const Icon(Icons.add),
      ),
    );
  }

  void addExercise() {
    debugPrint("Add Exercise");
    showDialog(context: context, builder: (context) {
      return NewExerciseDialog(onSubmit: (name, nSets, nReps, weight) {
        debugPrint("New Exercise: $name – $nSets sets, $nReps reps, $weight kg");
        setState(() {
          _exercises.add(ExerciseData(name, nSets, nReps, weight));
          widget.onExercisesChanged?.call(_exercises);
        });
        Navigator.of(context).pop();
      });
    });
  }
}


