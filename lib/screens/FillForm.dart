import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'FormData.dart';

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController birthDate = TextEditingController();

  late List<Map<String, dynamic>> formFields;

  @override
  void initState() {
    super.initState();

    // Initialize formFields in initState
    formFields = [
      {
        'label': 'Full Name',
        'type': 'text',
        'controller': fullName,
        'icon': Icons.drive_file_rename_outline,
      },
      {
        'label': 'Birth Date',
        'type': 'date',
        'controller': birthDate,
        'icon': Icons.date_range,
      },
      {
        'label': 'Gender',
        'type': 'dropdown',
        'options': ['Male', 'Female'],
        'value': 'Male', // Default value
        'iconData': Icons.male, // Default icon
      },
      {
        'label': 'City',
        'type': 'dropdown',
        'options': ['Cairo', 'Benha', 'Alex', 'NewYork', 'new jersey'],
        'value': 'Cairo', // Default value
        'icon': Icons.location_city, // Default icon
      },
      {
        'label': 'Are you Egyptian?',
        'type': 'switch',
        'icon': Icons.flag,
        'value': true,
      },
      {
        'label': 'Are you Student?',
        'type': 'switch',
        'icon': Icons.school,
        'value': false,
      }
    ];
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    fullName.dispose();
    birthDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // min date
      lastDate: DateTime(2030), // max date
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _validateAndNavigate() {
    final RegExp nameRegExp = RegExp(r'^[A-Za-z\s]+$');

    if (formFields[0]['controller'].text.isEmpty ||
        formFields[1]['controller'].text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all data!',
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } // end of empty condition
    else if (!nameRegExp.hasMatch(formFields[0]['controller'].text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Full Name should contain only letters and spaces!',
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } // end of fullName condition
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoPage(
            fullName: fullName.text,
            birthDate: birthDate.text,
            selectedGender: formFields[2]['value'],
            // Get selected gender from map
            isEgyptian: formFields[4]['value'],
            city: formFields[3]['value'],
            student: formFields[5]['value'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffC9A335),
        title: const Text(
          "Dynamic Form App",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: formFields.length,
                itemBuilder: (context, index) {
                  final field = formFields[index];
                  switch (field['type']) {
                    case 'text':
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: field['controller'],
                          decoration: InputDecoration(
                            hintText: field['label'],
                            prefixIcon: Icon(
                              field['icon'],
                              color: const Color(0xffC9A335),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffC9A335),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff1B1464),
                              ),
                            ),
                          ),
                        ),
                      );
                    case 'date':
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: field['controller'],
                          readOnly: true,
                          onTap: () =>
                              _selectDate(context, field['controller']),
                          decoration: InputDecoration(
                            hintText: field['label'],
                            prefixIcon: Icon(
                              field['icon'],
                              color: const Color(0xffC9A335),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffC9A335),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff1B1464),
                              ),
                            ),
                          ),
                        ),
                      );
                    case 'dropdown':
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: field['value'], // Bind the value from the map
                          decoration: InputDecoration(
                            hintText: field['label'],
                            prefixIcon: Icon(
                              field['label'] == 'Gender'
                                  ? field['iconData']
                                  : field['icon'],
                              color: const Color(0xffC9A335),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffC9A335),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff1B1464),
                              ),
                            ),
                          ),
                          items: field['options']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              field['value'] = newValue;

                              if (field['label'] == 'Gender') {
                                field['iconData'] = newValue == 'Male'
                                    ? Icons.male
                                    : Icons.female;
                              }
                            });
                          },
                        ),
                      );
                    case 'switch':
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SwitchListTile(
                            title: Text(field['label']),
                            value: field['value'],
                            activeColor: const Color(0xffC9A335),
                            onChanged: (bool value) {
                              setState(() {
                                field['value'] = value;
                              });
                            },
                            secondary: Icon(
                              field['label'] == 'Are you Egyptian?'
                                  ? (field['value']
                                      ? field['icon']
                                      : Icons
                                          .language) // condition for egy icon
                                  : (field['value']
                                      ? field['icon']
                                      : Icons.work), // condition  For Student
                              color: const Color(0xffC9A335),
                            )),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1B1464),
                padding:
                    const EdgeInsets.symmetric(horizontal: 105, vertical: 13),
              ),
              onPressed: _validateAndNavigate,
              child: const Text(
                "Next",
                style: TextStyle(color: Color(0xffC9A335), fontSize: 22),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
          ],
        ),
      ),
    );
  }
}
