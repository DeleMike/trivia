import 'package:flutter/material.dart';

class ViewAnswers extends StatelessWidget {
  static const routeName = '/view-answers';
  final widgets = <Widget>[
    Text('Hello - 1'),
    Text('Hello - 2'),
    Text('Hello - 3'),
    Text('Hello - 4'),
  ];
  @override
  Widget build(BuildContext context) {
    final tabs = ModalRoute.of(context).settings.arguments as Map<String, List<String>>;
    final questions = tabs['question'];
    final answers = tabs['answer'];
    print('Tabs: $tabs');
    print('Tabs Length: ${tabs.length}');
    return Scaffold(
      appBar: AppBar(title: Text('View Correct Answers')),
      body:
          PageView.builder(
            itemCount: tabs.length,
            itemBuilder: (ctx, i) {
              return Container(
                 padding: const EdgeInsets.all(8.0),
                 margin: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      SizedBox(height:10),
                      Text('Question ${i+1}'),
                      SizedBox(height:10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(questions[i], style: Theme.of(context).textTheme.headline6)),
                        SizedBox(height:10),
                        Divider(),
                        SizedBox(height:10),
                       Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(answers[i], style: Theme.of(context).textTheme.headline6)),
                      
                    ],
                  ),
              );
            },
          ),
    );
  }
}
