import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:three_d_blocks_test/game/components/block/block_deleter.dart';
import 'package:three_d_blocks_test/game/components/block/falling_box.dart';
import 'package:three_d_blocks_test/game/components/block/player_stack.dart';
import 'package:three_d_blocks_test/game/screens/game_loop.dart';
import 'package:three_d_blocks_test/game/static/constants.dart';
import 'package:three_d_blocks_test/game/static/game_state.dart';

class MyPlayer extends FallingBox {
  MyPlayer({
    required this.point,
    required super.imgPath,
    required super.startingPosition,
    required super.collisionBox,
    required super.positionCollisionBox,
  }) : super(customAnchor: Anchor.topCenter);

  int point;
  @override
  void render(Canvas canvas) {
    if (Constants.SHOW_COLLISION_BOX) {
      super.renderDebugMode(canvas);
    }
    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    acceleration = 0;
    isFalling = false;

    if (hitbox!.collisionType == CollisionType.active &&
        other is BlockDeleter) {
      (parent!.parent as GameLoop).resetGame();
      removeFromParent();
    }

    if (hitbox!.collisionType == CollisionType.active &&
        other.parent is PlayerStack) {
      setToPassive();
      (parent!.parent as GameLoop).givePoint();
      if (GameState.score > 1 &&
          position.y < (parent!.parent as GameLoop).size.y - 300) {
        (parent!.parent as GameLoop).lowerByValue += hitbox!.size.y / 3;
      }

      add(
        ScaleEffect.to(
          Vector2(scale.x - 0.01, scale.y - 0.1),
          EffectController(
            duration: 0.1,
            alternate: true,
            infinite: false,
          ),
        ),
      );
    }
  }

  @override
  void resetPosition() {
    position = startingPosition;
    acceleration = Constants.CUBE_WEIGHT * 0.01;
    isFalling = true;
    add(hitbox!);

    super.resetPosition();
  }
}
