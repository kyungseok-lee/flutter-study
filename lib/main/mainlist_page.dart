import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstudy/config/logger.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  Future<String> loadAsset() async {
    try {
      final data = await rootBundle.loadString("assets/api/list.json");
      logger.d("Data loaded successfully: $data");
      return data;
    } catch (e) {
      logger.e("Data loaded Error", error: e);
      return '{}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                Map<String, dynamic> list = jsonDecode(snapshot.data!);

                if (list["questions"] is List && list["questions"].isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, value) {
                      var title =
                          list["questions"][value]?["title"] ?? "쩨목 $value";

                      return InkWell(
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Text(title),
                          ),
                        ),
                        onTap: () {},
                      );
                    },
                    itemCount: list["questions"].length,
                  );
                }
              }
              return const Center(child: Text('No questions available'));
            case ConnectionState.none:
              return const Center(
                child: Text('No Data'),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
        future: loadAsset(),
      ),
    );
  }
}
