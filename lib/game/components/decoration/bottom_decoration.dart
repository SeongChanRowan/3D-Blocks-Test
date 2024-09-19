import 'package:flame/components.dart';
import 'package:three_d_blocks_test/game/components/block/falling_box.dart';

class BottomDecoration extends FallingBox {
  BottomDecoration({required Vector2 startingPosition})
      : super(
          imgPath: 'ground.png',
          startingPosition: startingPosition,
          collisionBox: Vector2(423, 240),
          positionCollisionBox: Vector2(125, -300),
          isFalling: false,
          customAnchor: Anchor.bottomCenter,
        );

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setToPassive();
  }
}
