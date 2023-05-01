import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_for_you_testing/model/product_model.dart';
import 'package:quotes_for_you_testing/model/quote_model.dart';

class RandomQuote extends StatefulWidget {
  const RandomQuote({super.key});

  @override
  State<RandomQuote> createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  List<QuoteModel> quoteList = [];
  Future<List<QuoteModel>> getRandomQuote() async {
    final response =
        await http.get(Uri.parse('https://zenquotes.io/api/random/[your_key]'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        quoteList.add(QuoteModel.fromJson(i));
      }
      return quoteList;
    } else {
      return quoteList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Quote'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                Center(
                  child: FutureBuilder(
                              future: getRandomQuote(),
                              builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(snapshot.data![0].q.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text(' - ${snapshot.data![0].a}', style: const TextStyle(fontSize: 16),)],
                          )
                        ],
                      ),
                    );
                  }
                              },
                            ),
                )
          ],
        ));
  }
}
