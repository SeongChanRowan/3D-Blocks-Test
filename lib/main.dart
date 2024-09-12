import 'package:three_d_blocks_test/components/game_loop.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/utils/background_decoration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  GameLoop game = GameLoop();
  runApp(GameWidget(
    game: kDebugMode ? GameLoop() : game,
    backgroundBuilder: (context) {
      return Stack(
        children: [
          Container(color: const Color.fromARGB(255, 133, 172, 255)),
          const BackgroundDecoration(),
        ],
      );
    },
  ));
}
