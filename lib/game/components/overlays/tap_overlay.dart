import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/screens/game_loop.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

class TapOverlay extends StatelessWidget {
  static const id = 'TapOverlay';
  final StackOver game;
  const TapOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) =>
          ((game).world.children.first as GameLoop).tapDown(),
      child: Container(
        color: const Color.fromARGB(0, 0, 0, 0),
        child: Image.asset(
          'assets/images/fog.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
