import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:three_d_blocks_test/components/player.dart';

class Toaster extends MyPlayer {
  Toaster({
    required startingPosition,
    animationName,
  }) : super(
          point: 1200,
          imgPath: 'block.png',
          startingPosition: startingPosition,
          collisionBox: Vector2(201, 125),
          positionCollisionBox: Vector2(50, -20),
          animationName: animationName,
        );
}
