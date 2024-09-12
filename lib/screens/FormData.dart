import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String fullName;
  final String birthDate;
  final String selectedGender;
  final bool isEgyptian;
  final bool student;

  final String city;

  const InfoPage({
    Key? key,
    required this.fullName,
    required this.birthDate,
    required this.selectedGender,
    required this.isEgyptian,
    required this.city,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffC9A335),
        title: const Text(
          "User Info",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ExpansionTile(
                textColor: const Color(0xff1B1464),
                collapsedBackgroundColor: const Color(0xffC9A335),
                collapsedTextColor: Colors.white,
                iconColor: const Color(0xff1B1464),
                title: const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person, color: Color(0xffC9A335)),
                    title: Text(
                      'Full Name: $fullName',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.date_range, color: Color(0xffC9A335)),
                    title: Text(
                      'Birth Date: $birthDate',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      selectedGender == 'Male' ? Icons.male : Icons.female,
                      color: const Color(0xffC9A335),
                    ),
                    title: Text(
                      'Gender: $selectedGender',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city,
                        color: Color(0xffC9A335)),
                    title: Text(
                      'City: $city',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      isEgyptian ? Icons.flag : Icons.language,
                      color: const Color(0xffC9A335),
                    ),
                    title: Text(
                      'Egyptian?: ${isEgyptian ? "Yes" : "No"}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school, color: Color(0xffC9A335)),
                    title: Text(
                      'Student?: ${student ? "Yes" : "No"}',
                      // use yes and no insted of flase
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
              onPressed: () {},
              child: const Text(
                "Submit",
                style: TextStyle(color: Color(0xffC9A335), fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
