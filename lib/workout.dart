import 'package:flutter/material.dart';
import 'exercise.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  final List<ExerciseData> _exercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Workout"),
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
        onPressed: () {
          addExercise();
        },
        tooltip: 'Add Exercise',
        child: const Icon(Icons.add),
      )
    );
  }

  void addExercise() {
    debugPrint("Add Exercise");
    showDialog(context: context, builder: (context) {
      return NewExerciseDialog(onSubmit: (name, nSets, nReps, weight) {
        debugPrint("New Exercise: $name – $nSets sets, $nReps reps, $weight kg");
        setState(() {
          _exercises.add(ExerciseData(name, nSets, nReps, weight));
        });
        Navigator.of(context).pop();
      });
    });
  }
}


