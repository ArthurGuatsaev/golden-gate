import 'package:flutter/material.dart';

import '../nav_manager.dart';

class VCloseButton extends StatelessWidget {
  const VCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyNavigatorManager.instance.simulatorPop(),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.4))),
        child: Icon(
          Icons.close,
          size: 25,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}
