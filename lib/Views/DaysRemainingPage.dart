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
    double offset = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Days Remaining'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: MediaQuery.of(context).size.width - offset,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  // Time until clocking out (6:00 PM)
                  'Slavery days:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Days, months, and years until the 19th of December 2028
                Text(
                  '${DateTime(2028, 12, 19).difference(DateTime.now()).inDays} days, '
                  '${DateTime(2028, 12, 19).difference(DateTime.now()).inHours % 24} hours, '
                  '${DateTime(2028, 12, 19).difference(DateTime.now()).inMinutes % 60} minutes, '
                  '${DateTime(2028, 12, 19).difference(DateTime.now()).inSeconds % 60} seconds',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
