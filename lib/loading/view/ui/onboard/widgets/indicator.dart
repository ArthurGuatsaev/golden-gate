import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../import.dart';

class MyCheckBox extends StatelessWidget {
  final int index;
  final int entity;
  const MyCheckBox({super.key, required this.index, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < entity; i++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<LoadBloc>()
                        .add(ChangeOnbIndicatorEvent(index: i));
                  },
                  child: SizedBox(
                    height: 8,
                    width: 8,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient:
                                index == i ? _gradient : _indicatorDisActive)),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
        ],
      ),
    );
  }
}

final _indicatorDisActive = LinearGradient(colors: [
  Colors.grey.withOpacity(0.3),
  Colors.grey.withOpacity(0.3),
]);
const _gradient = LinearGradient(colors: [
  Colors.white,
  Colors.white,
]);
