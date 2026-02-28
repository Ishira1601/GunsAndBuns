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
          TextFormField(initialValue: "$i"),
          TextFormField(initialValue: "$weight kg"),
          TextFormField(initialValue: "$nReps"),
        ]
      )
    );
  }
  return sets;
}

//------------------------------------------------------------------------------
// data model moved from workout.dart and made public
//------------------------------------------------------------------------------

class ExerciseData {
  final String name;
  final int sets;
  final int reps;
  final double weight;

  ExerciseData(this.name, this.sets, this.reps, this.weight);
}

//------------------------------------------------------------------------------
// dialog moved from workout.dart and renamed
//------------------------------------------------------------------------------

class NewExerciseDialog extends StatefulWidget {
  final void Function(String name, int nSets, int nReps, double weight) onSubmit;

  const NewExerciseDialog({super.key, required this.onSubmit});

  @override
  State<NewExerciseDialog> createState() => _NewExerciseDialogState();
}

class _NewExerciseDialogState extends State<NewExerciseDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _setsCtrl = TextEditingController();
  final TextEditingController _repsCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _setsCtrl.dispose();
    _repsCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Exercise'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Exercise'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _weightCtrl,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (double.tryParse(v) == null) return 'Must be a number';
                  return null;
                },
              ),
              TextFormField(
                controller: _setsCtrl,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (int.tryParse(v) == null) return 'Must be an integer';
                  return null;
                },
              ),
              TextFormField(
                controller: _repsCtrl,
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (int.tryParse(v) == null) return 'Must be an integer';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final name = _nameCtrl.text;
              final weight = double.parse(_weightCtrl.text);
              final sets = int.parse(_setsCtrl.text);
              final reps = int.parse(_repsCtrl.text);
              widget.onSubmit(name, sets, reps, weight);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}