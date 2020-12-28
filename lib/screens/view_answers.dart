import 'package:flutter/material.dart';

class ViewAnswers extends StatelessWidget {
  static const routeName = '/view-answers';
  @override
  Widget build(BuildContext context) {
    final tabs = ModalRoute.of(context).settings.arguments as List<Widget>;
    return Scaffold(
      appBar: AppBar(title: Text('View Correct Answers')),
      body: DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (ctx) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TabPageSelector(),
                    TabBarView(children: tabs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          child: Text('Finish'),
                          onPressed: () {
                            print('TabView: Finish');
                          },
                        ),
                        RaisedButton(
                          child: Text('Skip'),
                          onPressed: () {
                            print('TabView: Skip to end');
                            final controller = DefaultTabController.of(context);
                            if(!controller.indexIsChanging){
                              controller.animateTo(tabs.length - 1);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
