import 'dart:async';

import 'package:flutter/material.dart';

class VTimer extends StatefulWidget {
  final int duration;
  final DateTime date;

  const VTimer({super.key, required this.duration, required this.date});

  @override
  State<VTimer> createState() => _VTimerState();
}

class _VTimerState extends State<VTimer> {
  String time = '00:00';
  Timer? timer;
  @override
  void initState() {
    timerToString();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerToString();
      setState(() {});
      if (timer.tick >= widget.duration) timer.cancel();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void timerToString() {
    final left = widget.date.difference(DateTime.now()) +
        Duration(seconds: widget.duration);
    if (left.inSeconds < 0) timer!.cancel();
    int minute = 0;
    int second = 0;
    if (left.inMinutes >= 1) {
      minute = left.inMinutes;
      second = left.inSeconds - minute * 60;
    } else {
      second = left.inSeconds;
    }

    final min = '$minute'.length < 2 ? '0$minute' : '$minute';
    final sec = '$second'.length < 2 ? '0$second' : '$second';
    time = '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }
}
