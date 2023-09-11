import 'package:flutter/material.dart';

class ClockOutPage extends StatefulWidget {
  const ClockOutPage({Key? key}) : super(key: key);

  @override
  State<ClockOutPage> createState() => _ClockOutPageState();
}

class _ClockOutPageState extends State<ClockOutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Out'),
      ),
      body: const Center(
        child: Text('Clock Out'),
      ),
    );
  }
}
