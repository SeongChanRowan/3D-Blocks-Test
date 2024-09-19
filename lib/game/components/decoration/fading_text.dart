import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/static/game_state.dart';

class FadingText extends ShapeComponent {
  FadingText({required this.point, required this.newPosition})
      : super(scale: Vector2(1, 1));

  double? textSize;
  final int point;
  final Vector2 newPosition;

  @override
  Future<void> onLoad() async {
    if (point < 500) {
      textSize = 30;
    } else if (point < 1000) {
      textSize = 35;
    } else {
      textSize = 40;
    }
    GameState.totalpoint += point;
    position = newPosition;
    final regular = TextPaint(
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    anchor = Anchor.center;
    size = Vector2(300, 100);

    print("Loaded faded text");
    final textComponent = TextComponent(
      text: '+$point',
      anchor: Anchor.center,
      textRenderer: regular,
      position: Vector2(size.x / 2, size.y / 2),
    );

    final effect = MoveByEffect(
      Vector2(0, -50),
      EffectController(duration: 0.5),
    );

    final removeEffect = RemoveEffect(delay: 0.5);

    add(textComponent);
    add(effect);
    add(removeEffect);

    super.onLoad();
  }
}
