import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/logo_overlay.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/main_menu.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/pause_button.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/pause_menu.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/replay_menu.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/tap_overlay.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

void main() async {
  // initiate flame configuration
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  // initiate game
  runApp(
    GameWidget<StackOver>.controlled(
      overlayBuilderMap: {
        MainMenu.id: (_, game) => MainMenu(game),
        ReplayMenu.id: (_, game) => ReplayMenu(game),
        PauseButton.id: (_, game) => PauseButton(game),
        PauseMenu.id: (_, game) => PauseMenu(game),
        TapOverlay.id: (_, game) => TapOverlay(game),
        LogoOverlay.id: (_, game) => LogoOverlay(game),
      },
      initialActiveOverlays: const [
        TapOverlay.id,
        MainMenu.id,
        LogoOverlay.id,
      ],
      backgroundBuilder: (context) => Container(
        color: const Color.fromRGBO(224, 80, 104, 0.85),
      ),
      gameFactory: () => StackOver(),
    ),
  );
}
