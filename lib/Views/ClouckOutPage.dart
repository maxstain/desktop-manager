import 'package:desktop_manager/Shared/Data.dart';
import 'package:flutter/material.dart';

class ClockOutPage extends StatefulWidget {
  const ClockOutPage({Key? key}) : super(key: key);

  @override
  State<ClockOutPage> createState() => _ClockOutPageState();
}

class _ClockOutPageState extends State<ClockOutPage> {
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
    double offset = 30;
    late int hours =
        const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
    late int minutes =
        const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: const Text(
            'Time Remaining',
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
            color: SharedData().isFree == false ? Colors.white : Colors.green,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          width: MediaQuery.of(context).size.width - offset,
          height: 100,
          child: DateTime.now().month == 7 || DateTime.now().month == 8
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      // Time until clocking out (6:00 PM)
                      'Time until clocking out:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    hours > 0
                        ? Text(
                            '$hours hours '
                            '$minutes minutes',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            '$minutes minutes',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      // Time until clocking out (6:00 PM)
                      'Time until clocking out:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    hours > 0
                        ? Text(
                            '$hours hours '
                            '$minutes minutes',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            '$minutes minutes',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
        ),
      ],
    );
  }
}
