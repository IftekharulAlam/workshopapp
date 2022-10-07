import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class updateWorkshopPage extends StatefulWidget {
  String WorkshopID;
  String WorkshopName;
  String WorkshopDescription;
  String WorkshopTime;
  String WorkshopPlace;
  String InstructorName;
  String InstructorPhone;
  String Status;
  updateWorkshopPage({
    super.key,
    required this.WorkshopID,
    required this.WorkshopName,
    required this.WorkshopDescription,
    required this.WorkshopTime,
    required this.WorkshopPlace,
    required this.InstructorName,
    required this.InstructorPhone,
    required this.Status,
  });

  @override
  State<updateWorkshopPage> createState() => _updateWorkshopPageState();
}

class _updateWorkshopPageState extends State<updateWorkshopPage> {
  late String dropdownvalue;
  var items = ['Enable', 'Disable'];
  Future updateWorkshop(
      String WorkshopID,
      String WorkshopName,
      String WorkshopDescription,
      String WorkshopTime,
      String WorkshopPlace,
      String InstructorName,
      String InstructorPhone) async {
    http.Response response = await http
        .post(Uri.parse("http://192.168.0.100:8000/updateWorkshop"), body: {
      "WorkshopID": WorkshopID,
      "WorkshopName": WorkshopName,
      "WorkshopDescription": WorkshopDescription,
      "WorkshopTime": WorkshopTime,
      "WorkshopPlace": WorkshopPlace,
      "InstructorName": InstructorName,
      "InstructorPhone": InstructorPhone,
      "status": dropdownvalue
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Updated Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  static const String _title = 'My Workshop';
  TextEditingController WorkshopID = TextEditingController();
  TextEditingController WorkshopName = TextEditingController();
  TextEditingController WorkshopDescription = TextEditingController();
  TextEditingController WorkshopTime = TextEditingController();
  TextEditingController WorkshopPlace = TextEditingController();
  TextEditingController InstructorName = TextEditingController();
  TextEditingController InstructorPhone = TextEditingController();
  @override
  void initState() {
    super.initState();
    WorkshopID.text = widget.WorkshopID;
    WorkshopName.text = widget.WorkshopName;
    WorkshopDescription.text = widget.WorkshopDescription;
    WorkshopTime.text = widget.WorkshopTime;
    WorkshopPlace.text = widget.WorkshopPlace;
    InstructorName.text = widget.InstructorName;
    InstructorPhone.text = widget.InstructorPhone;
    dropdownvalue = widget.Status;
  }

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
                  'Update Workshop',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                readOnly: true,
                controller: WorkshopID,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workshop ID',
                ),
              ),
            ),
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
                controller: InstructorPhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Instructors Phone',
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: DropdownButton(
                  underline: Container(),
                  style: const TextStyle(
                      //te
                      color: Colors.black, //Font color
                      fontSize: 18 //font size on dropdown button
                      ),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Update Workshop'),
                onPressed: () {
                  if (WorkshopID.text != "" &&
                      WorkshopName.text != "" &&
                      WorkshopDescription.text != "" &&
                      WorkshopTime.text != "" &&
                      WorkshopPlace.text != "" &&
                      InstructorName.text != "" &&
                      InstructorPhone.text != "") {
                    updateWorkshop(
                        WorkshopID.text,
                        WorkshopName.text,
                        WorkshopDescription.text,
                        WorkshopTime.text,
                        WorkshopPlace.text,
                        InstructorName.text,
                        InstructorPhone.text);
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
