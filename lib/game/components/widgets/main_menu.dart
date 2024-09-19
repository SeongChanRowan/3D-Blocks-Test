import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/logo_overlay.dart';
import 'package:three_d_blocks_test/game/components/%08widgets/pause_button.dart';
import 'package:three_d_blocks_test/game/screens/game_loop.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';

// ignore: must_be_immutable
class MainMenu extends StatefulWidget {
  MainMenu(this.game, {super.key});
  Object? game;

  static const id = 'MainMenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: const Color.fromARGB(0, 5, 139, 222),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(36.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(72),
                              ),
                              child: Image.asset(
                                  'assets/images/logo_with_text.png')),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'TAP TO START',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        (widget.game as FlameGame).overlays.remove(MainMenu.id);
        (widget.game as FlameGame).overlays.remove(LogoOverlay.id);
        (widget.game as StackOver).overlays.add(PauseButton.id);
        ((widget.game as StackOver).world.children.first as GameLoop)
            .startGame();
      },
    );
  }
}
