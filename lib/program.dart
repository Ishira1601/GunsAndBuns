import 'package:flutter/material.dart';
import 'workout.dart';
import 'exercise.dart';

class Program extends StatefulWidget {
  const Program({super.key});

  @override
  State<Program> createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  int currentDay = 1;
  final Map<int, List<ExerciseData>> workoutDays = {};
  late GlobalKey<WorkoutState> _workoutKey;

  @override
  void initState() {
    super.initState();
    // Initialize first day with empty exercises list
    workoutDays[1] = [];
    _workoutKey = GlobalKey<WorkoutState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Workout(
                key: _workoutKey,
                currentDay: currentDay,
                exercises: workoutDays[currentDay] ?? [],
                onExercisesChanged: (exercises) {
                  setState(() {
                    workoutDays[currentDay] = exercises;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: currentDay > 1 ? _editPreviousDay : null,
                  child: Text('Edit Workout\nDay ${currentDay > 1 ? currentDay - 1 : 'N/A'}'),
                ),
                ElevatedButton(
                  onPressed: _finalizeProgram,
                  child: const Text('Finalize\nProgram'),
                ),
                ElevatedButton(
                  onPressed: _addWorkoutDay,
                  child: Text(workoutDays.containsKey(currentDay + 1)
                      ? 'Edit Workout\nDay ${currentDay + 1}'
                      : 'Add Workout\nDay ${currentDay + 1}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  

  void _addWorkoutDay() {
    final nextDay = currentDay + 1;
    setState(() {
      // move to next day
      currentDay = nextDay;
      // reset the key so Workout rebuilds with new day's data
      _workoutKey = GlobalKey<WorkoutState>();
      // if next day doesn't exist yet, create empty list; otherwise just open existing
      workoutDays.putIfAbsent(currentDay, () => []);
    });
    if (workoutDays[currentDay]!.isEmpty) {
      debugPrint('Created Workout Day $currentDay');
    } else {
      debugPrint('Opened existing Workout Day $currentDay');
    }
  }

  void _finalizeProgram() {
    debugPrint('Finalize Program with $currentDay days');
    // Implementation for finalize logic
  }

  void _editPreviousDay() {
    if (currentDay <= 1) return;
    setState(() {
      currentDay--;
      // ensure the day has an exercises list
      workoutDays.putIfAbsent(currentDay, () => []);
      // reset key so Workout rebuilds with the new day's data
      _workoutKey = GlobalKey<WorkoutState>();
    });
    debugPrint('Opened Workout Day $currentDay');
  }
}
