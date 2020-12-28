import 'package:flutter/material.dart';

class ViewAnswers extends StatelessWidget {
  static const routeName = '/view-answers';
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
                      Text('Question ${i+1}', style: Theme.of(context).textTheme.headline1),
                      SizedBox(height:10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(questions[i], style: Theme.of(context).textTheme.headline6),
                        )),
                        SizedBox(height:10),
                        Divider(),
                        SizedBox(height:10),
                        Text('Answer', style: Theme.of(context).textTheme.headline1),
                        SizedBox(height:10),
                       Container(
                          decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(answers[i], style: Theme.of(context).textTheme.headline5)),
                      
                    ],
                  ),
              );
            },
          ),
    );
  }
}
