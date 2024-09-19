import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';
  final StackOver game;

  const PauseMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (game as FlameGame).paused = false;
        (game).overlays.remove(PauseMenu.id);
      },
      child: Container(
        color: const Color.fromARGB(134, 0, 0, 0),
        child: const Center(
          child: Text(
            'PAUSED',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 48,
            ),
          ),
        ),
      ),
    );
  }
}
