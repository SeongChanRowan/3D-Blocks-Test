import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/components/overlays/utils/hover_image.dart';
import 'package:three_d_blocks_test/screens/game_loop.dart';
import 'package:three_d_blocks_test/stack_over.dart';
import 'package:three_d_blocks_test/static/game_state.dart';

// ignore: must_be_immutable
class ReplayMenu extends StatefulWidget {
  ReplayMenu(this.game, {this.score = 0, super.key});
  Object? game;
  int score;

  @override
  State<ReplayMenu> createState() => _ReplayMenuState();
}

class _ReplayMenuState extends State<ReplayMenu> {
  final Widget scoreTextGroup = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        const Text("Score",
            style: TextStyle(fontSize: 28, color: Color(0x50101120))),
        Text(GameState.score.toString(),
            style: const TextStyle(fontSize: 52, color: Color(0xa9474c8e))),
      ],
    ),
  );

  final Widget bestScoreTextGroup = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        const Text("Best",
            style: TextStyle(fontSize: 28, color: Color(0x50101120))),
        Text(GameState.bestScore.toString(),
            style: const TextStyle(fontSize: 52, color: Color(0xfffc8383))),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(127, 0, 0, 0),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Card(
              elevation: 20,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(
                width: 350,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // score
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [scoreTextGroup, bestScoreTextGroup],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HoverImage(
                          normalImage: 'assets/images/buttons/retry_up.png',
                          hoverImage: 'assets/images/buttons/retry_down.png',
                          onPressed: () {
                            (widget.game as FlameGame)
                                .overlays
                                .remove('replay-menu');
                            (widget.game as FlameGame)
                                .overlays
                                .add('pause-overlay');
                            ((widget.game as StackOver).world.children.first
                                    as GameLoop)
                                .startGame();
                          },
                          landScape: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30, // Adjust this value according to your preference
              child: SizedBox(
                width: 200,
                child: Image.asset("assets/images/logo_with_text.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
