import 'package:flutter/material.dart';
import 'dart:math' as math;

class MorphBlobWidget extends StatelessWidget {
  final AnimationController controller;

  const MorphBlobWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Stack(
          children: [
            // Top-right blob
            Positioned(
              top: -60 + (controller.value * 20),
              right: -40 + (controller.value * 15),
              child: _buildBlob(
                size: 220 + (controller.value * 30),
                color: const Color(0xFF2D6A4F).withAlpha(64),
                rotation: controller.value * math.pi * 0.15,
              ),
            ),
            // Mid-left blob
            Positioned(
              top: size.height * 0.25 + (controller.value * 30),
              left: -80 + (controller.value * 10),
              child: _buildBlob(
                size: 160 + (controller.value * 20),
                color: const Color(0xFF52B788).withAlpha(31),
                rotation: -controller.value * math.pi * 0.1,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlob({
    required double size,
    required Color color,
    required double rotation,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size * 0.6),
            topRight: Radius.circular(size * 0.35),
            bottomLeft: Radius.circular(size * 0.4),
            bottomRight: Radius.circular(size * 0.65),
          ),
        ),
      ),
    );
  }
}
