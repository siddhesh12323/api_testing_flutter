import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_for_you_testing/model/product_model.dart';

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  Future<ProductModel> getProductsAPI() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/39671690-47e0-491f-a24c-ef2138f13857'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Model'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![i].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![i].shop!.shopemail.toString()),
                            leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data![i].shop!.image.toString())),
                            trailing: Icon(snapshot.data!.data![i].inWishlist! == true ? Icons.favorite : Icons.favorite_outline),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemBuilder: (context, j) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.25,
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!.data![i].images![j].url
                                                .toString())),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.data![i].images!.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: snapshot.data!.data!.length,
                  );
                 }
                else {
                  return const Text('Loading...');
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
