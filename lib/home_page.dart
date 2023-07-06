import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_fetching/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? movieTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Http fetching"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (movieTitle != null)
              Text(
                movieTitle!,
                style: const TextStyle(fontSize: 18),
              ),
            if (movieTitle == null)
              const Text(
                'Click the button to fetch data',
                style: TextStyle(fontSize: 18),
              ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Icon(
                Icons.done_outline_sharp,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  //---------------------------------------------------------------

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(pathUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {

        final jsonData = jsonDecode(response.body);
        final movieList = jsonData['results'];
        final movieListLength = Random().nextInt(movieList.length);
        final randomMovie = movieList[movieListLength];
        final title = randomMovie['original_title'];

        setState(() {
          //for random title fetching------------------------

          movieTitle = title;

          // movieTitle = jsonData['results']
          //     [Random().nextInt(jsonData['results'].length)]['original_title'];

          //for single title fetching----------------------------

          // movieTitle = movieList[0]['original_title'];
        });
      } else {
        print("Error on server side");
      }
    } catch (error) {
      print("client side error");
    }
  }
}
