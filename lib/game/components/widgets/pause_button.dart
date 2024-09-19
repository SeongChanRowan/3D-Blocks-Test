import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/pause_menu.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/utils/hover_image.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

// ignore: must_be_immutable
class PauseButton extends StatelessWidget {
  static const id = 'PauseButton';
  final StackOver game;

  const PauseButton(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HoverImage(
            normalImage: 'assets/images/buttons/pause_up.png',
            hoverImage: 'assets/images/buttons/pause_down.png',
            onPressed: () {
              (game as FlameGame).overlays.add(PauseMenu.id);
              (game).paused = true;
            },
          ),
        ),
      ),
    );
  }
}
