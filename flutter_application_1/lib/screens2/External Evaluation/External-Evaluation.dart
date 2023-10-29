// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExternalEvaluation extends StatefulWidget {
  const ExternalEvaluation({super.key});

  @override
  State<ExternalEvaluation> createState() => _ExternalEvaluationState();
}

class _ExternalEvaluationState extends State<ExternalEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('External Evaluation'),
    );
  }
}
