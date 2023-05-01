import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final snackBar = const SnackBar(
    content: Text('Swiped right!'),
    duration: Duration(seconds: 3),
  );

  List<UserModel> userList = [];
  Future<List<UserModel>> getUsersAPI() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested API')),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              RowDisplay(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString()),
                              RowDisplay(
                                  title: 'Username',
                                  value: snapshot.data![index].username
                                      .toString()),
                              RowDisplay(
                                  title: 'E-mail',
                                  value:
                                      snapshot.data![index].email.toString()),
                              RowDisplay(
                                  title: 'Address',
                                  value:
                                      '${snapshot.data![index].address!.street.toString()}, ${snapshot.data![index].address!.suite.toString()}, ${snapshot.data![index].address!.city.toString()}')
                            ],
                          ),
                        );
                      },
                      itemCount: userList.length,
                    );
                  }
                },
                future: getUsersAPI(),
              ),
              onHorizontalDragEnd: (details) {
                //Right swipe
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  Navigator.pop(context);
                }
                //Left Swipe
                if (details.velocity.pixelsPerSecond.dx < 0) {
                  Navigator.pushNamed(context, '/productData');
                } 
              },
            ),
          )
        ],
      ),
    );
  }
}

class RowDisplay extends StatelessWidget {
  String title, value;
  RowDisplay({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
