import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CreateWorkshopPage extends StatefulWidget {
  const CreateWorkshopPage({super.key});

  @override
  State<CreateWorkshopPage> createState() => _CreateWorkshopPageState();
}

class _CreateWorkshopPageState extends State<CreateWorkshopPage> {
  Future createWorkshop(
      String WorkshopName,
      String WorkshopDescription,
      String WorkshopTime,
      String WorkshopPlace,
      String InstructorName,
      String InstructorPhone) async {
    http.Response response = await http
        .post(Uri.parse("http://192.168.31.124:8000/createWorkshop"), body: {
      "WorkshopName": WorkshopName,
      "WorkshopDescription": WorkshopDescription,
      "WorkshopTime": WorkshopTime,
      "WorkshopPlace": WorkshopPlace,
      "InstructorName": InstructorName,
      "InstructorPhone": InstructorPhone
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  static const String _title = 'My Workshop';
  TextEditingController WorkshopName = TextEditingController();
  TextEditingController WorkshopDescription = TextEditingController();
  TextEditingController WorkshopTime = TextEditingController();
  TextEditingController WorkshopPlace = TextEditingController();
  TextEditingController InstructorName = TextEditingController();
  TextEditingController InstructorPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'My Workshop',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Create Workshop',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: WorkshopName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workshop Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: WorkshopDescription,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workshop Description',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: WorkshopTime,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workshop Time',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: WorkshopPlace,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workshop Place',
                ),
              ),
            ),
            // Container(
            //   height: 50,
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: ElevatedButton(
            //     child: const Text('Upload Picture'),
            //     onPressed: () {
            //       //_openImagePicker();
            //     },
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: InstructorName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Instructors Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: InstructorPhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Instructors Phone',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Create Workshop'),
                onPressed: () {
                  if (WorkshopName.text != "" &&
                      WorkshopDescription.text != "" &&
                      WorkshopTime.text != "" &&
                      WorkshopPlace.text != "" &&
                      InstructorName.text != "" &&
                      InstructorPhone.text != "") {
                    createWorkshop(
                        WorkshopName.text,
                        WorkshopDescription.text,
                        WorkshopTime.text,
                        WorkshopPlace.text,
                        InstructorName.text,
                        InstructorPhone.text);
                    WorkshopName.text = "";
                    WorkshopDescription.text = "";
                    WorkshopTime.text = "";
                    WorkshopPlace.text = "";
                    InstructorName.text = "";
                    InstructorPhone.text = "";
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     const Text('Already have account?'),
            //     TextButton(
            //       child: const Text(
            //         'Login',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       onPressed: () {
            //         //login screen
            //         Navigator.pop(context);
            //       },
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
