import 'package:flutter/material.dart';

class DaysRemainingPage extends StatefulWidget {
  const DaysRemainingPage({Key? key}) : super(key: key);

  @override
  State<DaysRemainingPage> createState() => _DaysRemainingPageState();
}

class _DaysRemainingPageState extends State<DaysRemainingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Days Remaining'),
      ),
      body: Center(
        child: Text('Days Remaining'),
      ),
    );
  }
}
