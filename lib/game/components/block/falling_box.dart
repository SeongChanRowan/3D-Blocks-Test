import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:three_d_blocks_test/game/components/block/block_deleter.dart';
import 'package:three_d_blocks_test/game/static/constants.dart';

class FallingBox extends PositionComponent with CollisionCallbacks {
  FallingBox(
      {required this.imgPath,
      required this.startingPosition,
      required this.positionCollisionBox,
      this.collisionBox,
      this.isFalling = true,
      this.customAnchor = Anchor.bottomCenter})
      : super(scale: Vector2(.5, .5));

  final String imgPath;
  final Vector2? collisionBox;
  final Vector2 startingPosition;
  final Anchor customAnchor;
  Vector2 positionCollisionBox;
  bool isFalling;

  final _defaultColor = Color.fromARGB(135, 255, 86, 86);
  ShapeHitbox? hitbox;

  int id = 0;
  static int BOX_COUNT = 0;

  // gravity and acceleration
  static const double SPEED = Constants.SPEED;
  static const double CUBE_WEIGHT = Constants.CUBE_WEIGHT;
  double acceleration = CUBE_WEIGHT * 0.01;

  Random rnd = Random();
  Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 2400;

  @override
  Future<void> onLoad() async {
    id = BOX_COUNT++;

    position = startingPosition;
    anchor = customAnchor;

    // spawn sprite instead of animation
    final img = await Flame.images.load(imgPath);
    final sprite = SpriteComponent()
      ..sprite = Sprite(img)
      ..anchor = customAnchor;
    add(sprite);

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.fill;

    // make parallelogram hitbox
    Vector2 startingPos = positionCollisionBox;
    Vector2 startingSize = collisionBox ?? size;

    hitbox = PolygonHitbox([
      startingPos,
      startingPos + Vector2(startingSize.x / 2, startingSize.y / 2),
      startingPos +
          Vector2(startingSize.x / 2, startingSize.y + startingSize.y / 2),
      startingPos + Vector2(0, startingSize.y),
    ])
      ..paint = defaultPaint
      ..anchor = Anchor.bottomRight
      ..renderShape = Constants.SHOW_COLLISION_BOX;

    add(hitbox!);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isFalling) return;

    position += Vector2(0, 2) * dt * SPEED * acceleration;
    acceleration += 0.02 * dt * SPEED + 0.0002 * dt * SPEED * SPEED;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    spawnTouchDownEffects(other);
    super.onCollision(intersectionPoints, other);
  }

  void resetPosition() {}

  void setToPassive() {
    hitbox!.collisionType = CollisionType.passive;
  }

  Future<void> spawnTouchDownEffects(PositionComponent other) async {
    if (hitbox!.collisionType == CollisionType.passive ||
        other is BlockDeleter) {
      return;
    }
    final image = await Flame.images.load('splat.png');

    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 10,
          lifespan: 0.7,
          generator: (i) => AcceleratedParticle(
            acceleration: randomVector2(),
            child: ImageParticle(
              size: Vector2.all(34),
              image: image,
            ),
          ),
        ),
      ),
    );
  }
}
