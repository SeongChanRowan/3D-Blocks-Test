import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/components/block_deleter.dart';
import 'package:three_d_blocks_test/game/components/bottom_decoration/bottom_decoration.dart';
import 'package:three_d_blocks_test/game/components/crane/cable.dart';
import 'package:three_d_blocks_test/game/components/fading_text.dart';
import 'package:three_d_blocks_test/game/components/player.dart';
import 'package:three_d_blocks_test/game/components/player_stack.dart';
import 'package:three_d_blocks_test/game/components/score_board.dart';
import 'package:three_d_blocks_test/game/stack_over.dart';
import 'package:three_d_blocks_test/game/static/constants.dart';
import 'package:three_d_blocks_test/game/static/game_state.dart';

class GameLoop extends PositionComponent
    with TapCallbacks, HasCollisionDetection, HasGameReference<StackOver> {
  late MyPlayer player;
  late CraneCable crane;
  late BottomDecoration bottomDecoration;
  late PlayerStack playerStackComponent;
  late ScoreBoard scoreBoard;

  double lowerByValue = 0;

  @override
  Future<void> onLoad() async {
    size = Vector2(game.size.x, game.size.y);
    playerStackComponent = PlayerStack(size);
    bottomDecoration =
        BottomDecoration(startingPosition: Vector2(size.x / 2, size.y));
    playerStackComponent.players.add(bottomDecoration);

    crane = CraneCable(screenSize: size);
    scoreBoard = ScoreBoard(
        givenSize: Vector2(size.x / 2, size.x / 2),
        givenPosition: Vector2(size.x / 2, size.y / 2));
    add(scoreBoard);

    add(BlockDeleter(
        collisionBoxPosition: Vector2(-2000, size.y - 350),
        collisionBoxSize: Vector2(6000, 200)));
    add(BlockDeleter(
        collisionBoxPosition: Vector2(0, 3 * size.y),
        collisionBoxSize: Vector2(size.x * 3, 200)));
  }

  void tapDown() {
    if (crane.enabled) {
      crane.dropBox();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (lowerByValue > 0) {
      double offset = Constants.SPEED * dt * 1.5;
      lowerByValue -= offset;
      playerStackComponent.players.forEach((element) {
        element.position = element.position + Vector2(0, offset);
      });
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    playerStackComponent.parent ??= this;
    crane.parent ??= this;

    canvas.restore();

    super.render(canvas);
  }

  void resetGame() {
    // shake the screen
    add(MoveByEffect(
      Vector2.all(2.4),
      EffectController(
        duration: 0.1,
        alternate: true,
        infinite: false,
      ),
    ));

    for (final player in playerStackComponent.players) {
      player.removeFromParent();
    }
    playerStackComponent.players.clear();
    if (bottomDecoration.parent != null) bottomDecoration.removeFromParent();
    bottomDecoration =
        BottomDecoration(startingPosition: Vector2(size.x / 2, size.y));
    bottomDecoration.parent ??= this;
    playerStackComponent.players.add(bottomDecoration);

    // set best score
    if (GameState.score > GameState.bestScore) {
      GameState.bestScore = GameState.score;
    }

    playerStackComponent.balanceShiftX = 0;
    playerStackComponent.balanceShiftY = 0;
    playerStackComponent.position = Vector2(size.x / 2, size.y);

    // startGame();
    print("Game reset ${GameState.score}");
    game.overlays.add('replay-menu');
    game.overlays.remove('pause-overlay');
  }

  void givePoint() {
    add(MoveByEffect(
      Vector2.all(5),
      EffectController(
        duration: 0.2,
        alternate: true,
        infinite: false,
      ),
    ));
    GameState.score++;
    scoreBoard.updateScore(GameState.score);

    final Vector2 topPosition =
        playerStackComponent.players.last.position - Vector2(0, 0);
    final fadingText =
        FadingText(point: crane.currentpoint, newPosition: topPosition);

    add(fadingText);

    crane.spawnBox();
  }

  void startGame() {
    GameState.score = 0;
    GameState.totalpoint = 0;
    scoreBoard.updateScore(GameState.score);
    crane.resetPosition();
    crane.spawnBox();
  }
}
