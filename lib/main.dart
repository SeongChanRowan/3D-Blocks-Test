import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/components/overlays/main_menu.dart';
import 'package:three_d_blocks_test/components/overlays/replay_menu.dart';
import 'package:three_d_blocks_test/components/overlays/utils/hover_image.dart';
import 'package:three_d_blocks_test/screens/game_loop.dart';
import 'package:three_d_blocks_test/stack_over.dart';

void main() async {
  // initiate flame configuration
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  // load images
  await Flame.images.loadAll(const [
    'splat.png',
    'block.png',
  ]);

  // initiate game
  final game = StackOver();
  runApp(
    GameWidget(
      game: kDebugMode ? StackOver() : game,
      overlayBuilderMap: {
        'menu': (context, game) {
          return MainMenu(game);
        },
        'test': (context, game) {
          return Container(
              color: Colors.red,
              child: GestureDetector(
                  onTap: () => (game! as FlameGame).overlays.remove('test'),
                  child: const Text('Test')));
        },
        'replay-menu': (context, game) {
          return ReplayMenu(game);
        },
        'pause-overlay': (context, game) {
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
                    (game as FlameGame).overlays.add('pause');
                    (game).paused = true;
                  },
                ),
              ),
            ),
          );
        },
        'utilities-overlay': (context, game) {
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/rowan_logo.png'),
                ),
              ),
            ),
          );
        },
        'pause': (context, game) {
          return GestureDetector(
            onTap: () {
              (game as FlameGame).paused = false;
              (game).overlays.remove('pause');
            },
            child: Container(
              color: const Color.fromARGB(134, 0, 0, 0),
              child: const Center(
                child: Text(
                  'PAUSED',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 48,
                  ),
                ),
              ),
            ),
          );
        },
        'tap-overlay': (context, game) {
          return GestureDetector(
            onTapDown: (details) =>
                ((game as StackOver).world.children.first as GameLoop)
                    .tapDown(),
            child: Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Image.asset(
                'assets/images/fog.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        },
      },
      initialActiveOverlays: const ['tap-overlay', 'menu', 'utilities-overlay'],
      backgroundBuilder: (context) {
        return Stack(
          children: [
            Container(color: const Color.fromRGBO(224, 80, 104, 0.85)),
          ],
        );
      },
    ),
  );
}
