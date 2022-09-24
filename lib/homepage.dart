// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future getall() async {
  http.Response response = await http
      .get(Uri.parse("http://192.168.0.100:8000/getTemparatureDataApp"));

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getall(),
        builder: (BuildContext context, AsyncSnapshot sn) {
          if (sn.hasData) {
            List unis = sn.data;
            return ListView.builder(
              itemCount: unis.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => showProfilePage(
                  //       name: "${unis[index]["name"]}",
                  //       address: "${unis[index]["address"]}",
                  //       phone: "${unis[index]["phone"]}",
                  //       workingHour: "${unis[index]["workingHour"]}",
                  //       bytes: base64.decode(unis[index]["profilePic"]),
                  //     ),
                  //   ),
                  // );
                },
                child: Card(
                  child: ListTile(
                    // leading:Image.memory(base64.decode(unis[index]["profilePic"])),
                    title: Text("${unis[index]["name"]}"),
                    subtitle: Text("${unis[index]["phone"]}"),
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
