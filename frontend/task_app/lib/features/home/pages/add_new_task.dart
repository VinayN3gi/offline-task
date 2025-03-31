import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const AddNewTaskPage());

  const AddNewTaskPage({super.key});
  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  //Color selectedColor = Color.fromRGBO(246, 222, 194, 1);
  Color selectedColor = Colors.orangeAccent;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void submit() 
  {
    if(formKey.currentState!.validate())
    {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Add New Task"),
        actions: [
          GestureDetector(
              onTap: () async {
                final _selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)));

                if (_selectedDate != null) {
                  setState(() {
                    selectedDate = _selectedDate;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat("MM-d-y").format(selectedDate),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //Title form field
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a ttile";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              //Description form field
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ColorPicker(
                heading: const Text('Select color'),
                subheading: const Text('Select a different shade'),
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                color: selectedColor,
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: submit,
                  child: Text(
                    "Add task",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
