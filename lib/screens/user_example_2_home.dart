import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
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
      appBar: AppBar(title: const Text('User Model')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
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
                              value: snapshot.data![index].username.toString()),
                          RowDisplay(
                              title: 'E-mail',
                              value: snapshot.data![index].email.toString())
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
