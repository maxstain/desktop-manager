import 'package:flutter/material.dart';

class ClockOutPage extends StatefulWidget {
  final bool isFree;
  const ClockOutPage({Key? key, required this.isFree}) : super(key: key);

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
    double offset = 30;
    late int hours =
        const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
    late int minutes =
        const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Out'),
      ),
      body: Container(
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
    );
  }
}
