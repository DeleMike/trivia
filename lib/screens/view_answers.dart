import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';

///[ViewAnswers] screen is used to view the right answer to each question.
class ViewAnswers extends StatelessWidget {
  static const routeName = '/view-answers';
  @override
  Widget build(BuildContext context) {
    final tabs = ModalRoute.of(context)!.settings.arguments as Map<String, List<String>>;
    final questions = tabs['question'];
    final answers = tabs['answer'];
    print('Tabs: $tabs');
    print('Tabs Length: ${tabs.length}');
    return Scaffold(
      appBar: AppBar(title: Text('View Correct Answers')),
      body:
          PageView.builder(
            itemCount: tabs['question']!.length,
            itemBuilder: (ctx, i) {
              return Container(
                 padding: const EdgeInsets.all(8.0),
                 margin: const EdgeInsets.all(8.0),
                child: Consumer<DarkThemeProvider>(
                                  builder: (_, theme, __) => Column(
                      children: [
                        SizedBox(height:10),
                        Text('Question ${i+1}', style: Theme.of(context).textTheme.headline1),
                        SizedBox(height:10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: theme.darkTheme ? Colors.white: Colors.black,),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(questions![i], style: Theme.of(context).textTheme.headline6),
                          )),
                          SizedBox(height:10),
                          Divider(),
                          SizedBox(height:10),
                          Text('Answer', style: Theme.of(context).textTheme.headline1),
                          SizedBox(height:10),
                         Container(
                            decoration: BoxDecoration(
                            border: Border.all(width: 1, color: theme.darkTheme ? Colors.white: Colors.black,),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(answers![i], style: Theme.of(context).textTheme.headline5)),
                        
                      ],
                    ),
                ),
              );
            },
          ),
    );
  }
}
