import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

class LogoOverlay extends StatelessWidget {
  static const id = 'LogoOverlay';
  final StackOver game;

  const LogoOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 100,
            child: Image.asset('assets/images/rowan_logo.png'),
          ),
        ),
      ),
    );
  }
}
