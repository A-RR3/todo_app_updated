import 'package:flutter/material.dart';

class LoadingStateScreen extends StatelessWidget {
  const LoadingStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}