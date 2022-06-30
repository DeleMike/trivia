import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/quiz_page_controller.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({Key? key}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  @override
  void initState() {
    super.initState();
    debugPrint('InitState called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Result Screen'),
          ElevatedButton.icon(
              onPressed: () {
                context.read<QuizPageController>().clearResources();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coming soon...')));
              },
              icon: const Icon(Icons.delete_sweep_outlined),
              label: const Text('Clear Resources')),
        ],
      )),
    );
  }
}
