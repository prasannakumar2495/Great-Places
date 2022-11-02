import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatplaces/provider/great_places.dart';
import 'package:greatplaces/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/addPlace';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      scaffoldMessenger('Title/Image is Empty!');
      return;
    } else {
      scaffoldMessenger('Saved');
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage!);
      Navigator.of(context).pop();
    }
  }

  void scaffoldMessenger(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            // style: ButtonStyle(
            //   elevation: MaterialStateProperty.all(0),
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
