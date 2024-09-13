import 'dart:math';
import 'package:flame/components.dart';
import 'package:three_d_blocks_test/components/player.dart';
import 'package:three_d_blocks_test/components/players/toster.dart';

class PlayerFactory {
  static MyPlayer createPlayer(Vector2 startingPosition) {
    const List<String> playerTypes = [
      'toaster',
    ];
    // generate a random number between 0 and len(playerTypes)
    final random = Random();
    final randomIndex = random.nextInt(playerTypes.length);
    final randomPlayerType = playerTypes[randomIndex];

    switch (randomPlayerType) {
      case 'toaster':
        return Toaster(
            startingPosition: startingPosition, animationName: "toaster");
      default:
        throw Exception('Invalid player type');
    }
  }
}
