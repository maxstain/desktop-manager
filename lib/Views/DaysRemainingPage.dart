import 'package:desktop_manager/Shared/Data.dart';
import 'package:flutter/material.dart';

class DaysRemainingPage extends StatefulWidget {
  const DaysRemainingPage({Key? key}) : super(key: key);

  @override
  State<DaysRemainingPage> createState() => _DaysRemainingPageState();
}

class _DaysRemainingPageState extends State<DaysRemainingPage> {
void checker() {
    setState(() {
      if (DateTime.now().weekday == DateTime.saturday ||
          DateTime.now().weekday == DateTime.sunday) {
        SharedData().isFree = true;
        SharedData().isWeekend = true;
      } else if (DateTime.now().hour >= 18) {
        SharedData().isFree = true;
      } else if (DateTime.now().hour < 9) {
        SharedData().isFree = true;
      } else if (DateTime.now().month == 7 || DateTime.now().month == 8) {
        if (DateTime.now().hour >= 16) {
          SharedData().isFree = true;
        } else {
          SharedData().isFree = false;
        }
      }
      if (DateTime(2028, 12, 19) == DateTime.now()) {
        SharedData().isLastDay = true;
      } else {
        SharedData().isFree = false;
      }
    });
  }

  void _timer() {
    Future.delayed(const Duration(seconds: 1), () {
      checker();
      _timer();
    });
  }
  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double offset = SharedData().offset;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: const Text(
            'Days Remaining',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
          height: MediaQuery.of(context).size.height - 150,
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
    );
  }
}
