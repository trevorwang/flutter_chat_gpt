import 'package:flutter/material.dart';

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: Text("hello"),
    );
  }
}
