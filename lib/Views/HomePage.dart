// ignore_for_file: must_be_immutable

import 'package:desktop_manager/Views/ClouckOutPage.dart';
import 'package:desktop_manager/Views/DaysRemainingPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

double offset = 30;
late int hours =
    const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
late int minutes =
    const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
int index = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isFree = false;
  late bool isWeekend = false;
  late bool isLastDay = false;

  void checker() {
    setState(() {
      if (DateTime.now().weekday == DateTime.saturday ||
          DateTime.now().weekday == DateTime.sunday) {
        isFree = true;
        isWeekend = true;
      } else if (DateTime.now().hour >= 18) {
        isFree = true;
      } else if (DateTime.now().hour < 9) {
        isFree = true;
      } else if (DateTime.now().month == 7 || DateTime.now().month == 8) {
        if (DateTime.now().hour >= 16) {
          isFree = true;
        } else {
          isFree = false;
        }
      }
      if (DateTime(2028, 12, 19) == DateTime.now()) {
        isLastDay = true;
      } else {
        isFree = false;
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
  Widget build(BuildContext context) {
    //
    const List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.lock_clock_rounded),
        label: 'Clock Out Time',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_rounded),
        label: 'Total Days Remaining',
      ),
    ];

    return Scaffold(
      backgroundColor: isFree == false ? Colors.white : Colors.green,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
      ),
      body: index == 0
          ? Home(
              isFree: isFree,
              isWeekend: isWeekend,
              isLastDay: isLastDay,
            )
          : index == 1
              ? ClockOutPage(isFree: isFree)
              : const DaysRemainingPage(),
    );
  }
}

class Home extends StatefulWidget {
  bool isFree = false;
  bool isWeekend = false;
  bool isLastDay = false;
  Home({
    Key? key,
    required this.isFree,
    required this.isWeekend,
    required this.isLastDay,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        !widget.isLastDay
            ? Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'TODAY IS YOUR LAST DAY!!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Today\'s date and time:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${DateTime.now().toString().substring(0, 10)} ${DateTime.now().toString().substring(11, 16)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.isFree == false ? Colors.white : Colors.green,
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
        Lottie.asset(
          widget.isFree == false
              ? 'assets/lottie/Black1.json'
              : 'assets/lottie/BearLottie.json',
          height: 300,
          width: 300,
          options: LottieOptions(enableMergePaths: true),
        ),
        Text(
          widget.isFree == false && widget.isLastDay == false
              ? 'You are currently not free'
              : widget.isFree && widget.isLastDay
                  ? 'YOU ARE FINALLY FREE!!!'
                  : 'YOU ARE FREE FOR THE REST OF THE DAY!!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
