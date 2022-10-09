// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:workshopapp/createWorkshopScreen.dart';
import 'package:workshopapp/registerUser.dart';
import 'package:workshopapp/showWorkshopDetails.dart';
import 'package:workshopapp/updateWorkshopPage.dart';

class HomePage extends StatefulWidget {
  String id;
  String type;
  HomePage({super.key, required this.id, required this.type});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future getProfileInfo(String ID, String typeOf) async {
  http.Response response = await http.post(
      Uri.parse("http://192.168.0.100:8000/getProfileInfo"),
      body: {"ID": ID, "type": typeOf});

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

Future getWorkshopListof(String ID, String typeOf) async {
  http.Response response = await http.post(
      Uri.parse("http://192.168.0.100:8000/getworkshopListmy"),
      body: {"ID": ID, "type": typeOf});

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

Future applyForWorkshop(
    String Workshop_ID, String Workshop_Name, String Student_ID) async {
  http.Response response = await http
      .post(Uri.parse("http://192.168.0.100:8000/applyForWorkshop"), body: {
    "Workshop_ID": Workshop_ID,
    "Workshop_Name": Workshop_Name,
    "Student_ID": Student_ID,
  });

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

Future getall() async {
  http.Response response =
      await http.get(Uri.parse("http://192.168.0.100:8000/getworkshopList"));

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

Future removeWorkshop(String WorkshopID) async {
  http.Response response = await http
      .post(Uri.parse("http://192.168.0.100:8000/removeWorkshop"), body: {
    "WorkshopID": WorkshopID,
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

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Workshop List")),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.account_circle_outlined)),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: getProfileInfo(widget.id, widget.type),
          builder: (BuildContext context, AsyncSnapshot sn) {
            if (sn.hasData) {
              List unis = sn.data;
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: unis.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DrawerHeader(child: Icon(Icons.access_alarms)),
                    ListTile(
                      title:
                          Center(child: Text("Name : ${unis[index]["Name"]}")),
                    ),
                    ListTile(
                      title: Center(
                          child: Text(" Address : ${unis[index]["ID"]}")),
                    ),
                    ListTile(
                      title: Center(
                          child: Text(" Email : ${unis[index]["Email"]}")),
                    ),
                    ListTile(
                      title: Center(
                          child: Text(" Phone : ${unis[index]["Phone"]}")),
                    ),
                    ListTile(
                      title: Center(child: Text("${unis[index]["Type"]}")),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Delete Account'),
                        onPressed: () {
                          // deleteProfile(unis[index]["name"],
                          //     unis[index]["phone"], widget.type);
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            if (sn.hasError) {
              return Center(child: Text("Error Loading Data"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      body: Column(
        children: [
          widget.type == "Student"
              ? Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Create Workshop'),
                            onPressed: () {
                              //login();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateWorkshopPage()),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Create Instructor'),
                            onPressed: () {
                              //login();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationPageUser()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            child: FutureBuilder(
              future: getWorkshopListof(widget.id, widget.type),
              builder: (BuildContext context, AsyncSnapshot sn) {
                if (sn.hasData) {
                  List unis = sn.data;
                  return ListView.builder(
                    itemCount: unis.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => showWorkshopDetails(
                              Name: "${unis[index]["Name"]}",
                              Description: "${unis[index]["Description"]}",
                              Time: "${unis[index]["Time"]}",
                              Place: "${unis[index]["Place"]}",
                              InstructorName:
                                  "${unis[index]["InstructorName"]}",
                              InstructorPhone:
                                  "${unis[index]["InstructorPhone"]}",
                              status: "${unis[index]["status"]}",
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("${unis[index]["Name"]}"),
                          subtitle: Text("${unis[index]["Time"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.type == "Admin"
                                  ? Container(
                                      height: 50,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: ElevatedButton(
                                        child: Icon(Icons.edit_note_rounded),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  updateWorkshopPage(
                                                WorkshopID:
                                                    "${unis[index]["ID"]}",
                                                WorkshopName:
                                                    "${unis[index]["Name"]}",
                                                WorkshopDescription:
                                                    "${unis[index]["Description"]}",
                                                WorkshopTime:
                                                    "${unis[index]["Time"]}",
                                                WorkshopPlace:
                                                    "${unis[index]["Place"]}",
                                                InstructorName:
                                                    "${unis[index]["InstructorName"]}",
                                                InstructorPhone:
                                                    "${unis[index]["InstructorPhone"]}",
                                                Status:
                                                    "${unis[index]["status"]}",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(),
                              widget.type == "Admin"
                                  ? Container(
                                      height: 50,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: ElevatedButton(
                                        child: Icon(Icons.delete),
                                        onPressed: () {
                                          removeWorkshop(
                                              unis[index]["ID"].toString());
                                        },
                                      ),
                                    )
                                  : Container(),
                              widget.type == "Student"
                                  ? unis[index]["AppStatus"] == 'Yes'
                                      ? Container(
                                          height: 50,
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: const Text('Applied'),
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg: "Already Applied",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: ElevatedButton(
                                            child: const Text('Apply'),
                                            onPressed: () {
                                              setState(() {
                                                applyForWorkshop(
                                                    unis[index]["ID"]
                                                        .toString(),
                                                    unis[index]["Name"],
                                                    widget.id);
                                              });
                                            },
                                          ),
                                        )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (sn.hasError) {
                  return Center(child: Text("Error Loading Data"));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
