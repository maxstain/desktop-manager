import 'package:desktop_manager/Views/ClouckOutPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
    double offset = 30;
    late int hours =
        const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
    late int minutes =
        const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
    return Scaffold(
      backgroundColor: isFree == false ? Colors.white : Colors.green,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(title: widget.title),
              ),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.lock_clock_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ClockOutPage(),
              ),
            ),
          ),
          label: 'Clock Out Time',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(title: widget.title),
              ),
            ),
          ),
          label: 'Total Days Remaining',
        ),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLastDay
              ? const Text(
                  'TODAY IS YOUR LAST DAY!!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${DateTime.now().toString().substring(0, 10)} ${DateTime.now().toString().substring(11, 16)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
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
              color: isFree == false ? Colors.white : Colors.green,
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
                    overflow: TextOverflow.ellipsis,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Lottie.asset(
            isFree == false
                ? 'assets/lottie/Black1.json'
                : 'assets/lottie/BearLottie.json',
            height: 300,
            width: 300,
            options: LottieOptions(enableMergePaths: true),
            onLoaded: (composition) {
              setState(() {
                checker();
              });
            },
          ),
          Text(
            isFree == false && isLastDay == false
                ? 'You are currently not free'
                : isFree && isLastDay
                    ? 'YOU ARE FINALLY FREE!!!'
                    : 'YOU ARE FREE FOR THE REST OF THE DAY!!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
