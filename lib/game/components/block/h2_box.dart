import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:three_d_blocks_test/game/components/block/player.dart';

class H2Box extends MyPlayer {
  H2Box({
    required startingPosition,
  }) : super(
          point: 100,
          imgPath: 'block.png',
          startingPosition: startingPosition,
          collisionBox: Vector2(201, 125),
          positionCollisionBox: Vector2(50, -20),
        );
}
