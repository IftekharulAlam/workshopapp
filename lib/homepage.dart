// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:workshopapp/createWorkshopScreen.dart';
import 'package:workshopapp/showWorkshopDetails.dart';
import 'package:workshopapp/updateWorkshopPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Workshop List")),
      ),
      body: FutureBuilder(
        future: getall(),
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
                        InstructorName: "${unis[index]["InstructorName"]}",
                        InstructorPhone: "${unis[index]["InstructorPhone"]}",
                        status: "${unis[index]["status"]}",
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    // leading:Image.memory(base64.decode(unis[index]["profilePic"])),
                    title: Text("${unis[index]["Name"]}"),
                    subtitle: Text("${unis[index]["Time"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: Icon(Icons.edit_note_rounded),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => updateWorkshopPage(
                                    WorkshopID: "${unis[index]["ID"]}",
                                    WorkshopName: "${unis[index]["Name"]}",
                                    WorkshopDescription:
                                        "${unis[index]["Description"]}",
                                    WorkshopTime: "${unis[index]["Time"]}",
                                    WorkshopPlace: "${unis[index]["Place"]}",
                                    InstructorName:
                                        "${unis[index]["InstructorName"]}",
                                    InstructorPhone:
                                        "${unis[index]["InstructorPhone"]}",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              removeWorkshop(unis[index]["ID"].toString());
                            },
                          ),
                        ),
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
    );
  }
}
