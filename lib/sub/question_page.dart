import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstudy/config/logger.dart';
import 'package:flutterstudy/detail/detail_page.dart';

class QuestionPage extends StatefulWidget {
  final String question;

  const QuestionPage({super.key, required this.question});

  @override
  State<QuestionPage> createState() {
    return _QuestionPage();
  }
}

class _QuestionPage extends State<QuestionPage> {
  int selectNumber = -1;

  Future<String> loadAsset(String fileName) async {
    logger.debug('loadAsset fileName: $fileName');
    return await rootBundle.loadString('assets/api/$fileName.json');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsset(widget.question),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            ),
          );
        }

        Map<String, dynamic> questions = jsonDecode(snapshot.data as String);
        String title = questions['title'].toString();
        List<Widget> widgets = List<Widget>.generate(
          (questions['selects'] as List<dynamic>).length,
          (index) => SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(questions['selects'][index]),
                Radio(
                  value: index,
                  groupValue: selectNumber,
                  onChanged: (value) {
                    setState(() {
                      selectNumber = value as int;
                    });
                  },
                ),
              ],
            ),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
            children: [
              Text(questions['question'].toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                ),
              ),
              selectNumber == -1
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(
                                answer: questions['answer'][selectNumber],
                                question: questions['question'],
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('선택 보기'),
                    ),
            ],
          ),
        );
      },
    );
  }
}
