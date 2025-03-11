import 'package:flutter/material.dart';

class adddiet extends StatelessWidget {
  const adddiet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD_DIET'),
      ),
      body: const Center(
        child: Text('Add your diet here'),
      ),
    );
  }
}
