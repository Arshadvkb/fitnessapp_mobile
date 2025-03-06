import 'package:flutter/material.dart';

class health_tips extends StatelessWidget {
  const health_tips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HEALTH_TIPS'),
        ),
        body: Center(
          child: Text('View health tips here.'),
        ));
  }
}
