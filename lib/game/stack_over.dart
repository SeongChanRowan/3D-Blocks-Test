import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';

import 'package:three_d_blocks_test/game/screens/game_loop.dart';

class StackOver extends FlameGame {
  StackOver()
      : super(
          camera: CameraComponent.withFixedResolution(width: 400, height: 700),
          world: FixedResolutionWorld(),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}

class FixedResolutionWorld extends World
    with HasGameReference, TapCallbacks, DoubleTapCallbacks {
  @override
  Future<void> onLoad() async {
    add(GameLoop()..anchor = Anchor.center);
    super.onLoad();
  }
}
