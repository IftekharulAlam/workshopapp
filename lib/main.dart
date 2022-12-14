// ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:workshopapp/createWorkshopScreen.dart';
import 'package:workshopapp/homepage.dart';
import 'package:workshopapp/registerUser.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'My Workshop ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownvalue = 'Student';
  var items = ['Student', 'Instructor', 'Admin'];
  TextEditingController ID = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    String finalUrl = "http://192.168.0.100:8000/login";
    var url = Uri.parse(finalUrl);
    var response = await http.post(url, body: {
      "ID": ID.text,
      "password": password.text,
      "userType": dropdownvalue
    });

    var data = json.decode(response.body)["message"];
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  id: ID.text,
                  type: dropdownvalue,
                )),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Login Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'My Workshop ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ID,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'User Type:',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
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
              ],
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  login();
                },
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Looking for worker ?'),
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPageUser()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            // Row(
            //   children: <Widget>[
            //     const Text('Are you looking for work?'),
            //     TextButton(
            //       child: const Text(
            //         'Create ',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       onPressed: () {
            //         //signup screen
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const CreateWorkshopPage()),
            //         );
            //       },
            //     )
            //   ],
            //   mainAxisAlignment: MainAxisAlignment.center,
            // ),
          ],
        ));
  }
}
