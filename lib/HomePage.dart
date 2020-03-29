import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://randomuser.me/api/?results=50";
  List usersData;
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    this.getData();
  }

  Future getData() async {
    var apiData = await http.get(url);
    var data = jsonDecode(apiData.body)['results'];

    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Random Users',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Fetching the data , Please wait',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    CircularProgressIndicator()
                  ],
                )
              : ListView.builder(
                  itemCount: usersData == null ? 0 : usersData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(
                        bottom: 10.0,
                        left: 5.0,
                        top: 10.0,
                      ),
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(17.0),
                            height: 85,
                            width: 85,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                usersData[index]["picture"]["large"],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${usersData[index]["name"]["title"]} ${usersData[index]["name"]["first"]}',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 7.0,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      size: 20.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5.0,
                                      ),
                                    ),
                                    Text(
                                      '${usersData[index]["phone"]}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5.0,
                                      ),
                                    ),
                                    Text(
                                      '${usersData[index]["gender"]}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5.0,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMd().format(
                                        DateTime.parse(
                                            usersData[index]["dob"]["date"]),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.email,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5.0,
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        '${usersData[index]["email"]}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 7.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
