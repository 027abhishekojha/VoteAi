import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimer({
    Key? key,
    required this.endTime,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.endTime.difference(DateTime.now());
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft = widget.endTime.difference(DateTime.now());
        if (_timeLeft.isNegative) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft.isNegative) {
      return const Text('Expired');
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${_timeLeft.inDays}d ${_timeLeft.inHours % 24}h ${_timeLeft.inMinutes % 60}m',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}