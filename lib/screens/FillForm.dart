import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'FormData.dart';

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  TextEditingController fullName = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  String? selectedGender = 'Male'; // Default value is "Male"
  IconData genderIcon = Icons.male; // Default icon is the male icon
  bool isEgyptian = false; // Default value for the switch

  @override
  void dispose() {
    birthDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        birthDate.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _validateAndNavigate() {
    final RegExp nameRegExp = RegExp(r'^[A-Za-z\s]+$');

    if (fullName.text.isEmpty || birthDate.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all data!',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!nameRegExp.hasMatch(fullName.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Full Name should contain only letters and spaces!',
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoPage(
            fullName: fullName.text,
            birthDate: birthDate.text,
            selectedGender: selectedGender ?? 'Male',
            isEgyptian: isEgyptian,
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
          "Form App",
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
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            TextField(
              controller: fullName,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Full Name",
                prefixIcon: Icon(
                  Icons.drive_file_rename_outline,
                  color: Color(0xffC9A335),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC9A335),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff1B1464),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            TextField(
              controller: birthDate,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                hintText: "Birth Date",
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Color(0xffC9A335),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC9A335),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff1B1464),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: "Gender",
                prefixIcon: Icon(
                  genderIcon, // Update icon based on gender which user choose
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
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                  genderIcon =
                      selectedGender == 'Male' ? Icons.male : Icons.female;
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            SwitchListTile(
              title: const Text('Are you Egyptian?'),
              value: isEgyptian,
              activeColor: const Color(0xffC9A335),
              onChanged: (bool value) {
                setState(() {
                  isEgyptian = value;
                });
              },
              secondary: Icon(
                isEgyptian ? Icons.flag : Icons.language,
                color: const Color(0xffC9A335),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
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
          ],
        ),
      ),
    );
  }
}
