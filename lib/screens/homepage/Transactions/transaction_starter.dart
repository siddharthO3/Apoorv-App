import 'package:flutter/material.dart';

class TransactionStart extends StatefulWidget {
  static const routeName = '/transaction-start';
  const TransactionStart({super.key});

  @override
  State<TransactionStart> createState() => _TransactionStartState();
}

class _TransactionStartState extends State<TransactionStart> {
  @override
  Widget build(BuildContext context) {
    String to_uid = ModalRoute.of(context)!.settings.arguments as String;
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
