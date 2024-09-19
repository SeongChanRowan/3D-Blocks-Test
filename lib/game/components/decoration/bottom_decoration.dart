import 'package:flame/components.dart';
import 'package:three_d_blocks_test/game/components/block/falling_box.dart';

class BottomDecoration extends FallingBox {
  BottomDecoration({required super.startingPosition})
      : super(
          imgPath: 'ground.png',
          collisionBox: Vector2(423, 240),
          positionCollisionBox: Vector2(125, -300),
          isFalling: false,
          customAnchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setToPassive();
  }
}
