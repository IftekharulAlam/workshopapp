// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class showWorkshopDetails extends StatefulWidget {
  String Name;
  String Description;
  String Time;
  String Place;
  String InstructorName;
  String InstructorPhone;
  String status;

  showWorkshopDetails({
    super.key,
    required this.Name,
    required this.Description,
    required this.Time,
    required this.Place, 
    required this.InstructorName,
    required this.InstructorPhone,
    required this.status,
  });

  @override
  State<showWorkshopDetails> createState() => _showWorkshopDetailsState();
}

class _showWorkshopDetailsState extends State<showWorkshopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: const Color.fromARGB(255, 89, 0, 255),
            child: const Text("Profile")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name: ${widget.Name}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description: ${widget.Description}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time: ${widget.Time}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Place: ${widget.Place}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Instructor Name: ${widget.InstructorName}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Instructor Phone: ${widget.InstructorPhone}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Status: ${widget.status}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
