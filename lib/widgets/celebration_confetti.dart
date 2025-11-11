import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Widget de confetti para celebraciones
/// Usado en pantallas de completación de actividades exitosas
class CelebrationConfetti extends StatefulWidget {
  final bool show;
  final int numberOfParticles;

  const CelebrationConfetti({
    Key? key,
    this.show = false,
    this.numberOfParticles = 50,
  }) : super(key: key);

  @override
  State<CelebrationConfetti> createState() => _CelebrationConfettiState();
}

class _CelebrationConfettiState extends State<CelebrationConfetti>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _initializeParticles();

    if (widget.show) {
      _controller.forward();
    }
  }

  void _initializeParticles() {
    _particles.clear();
    for (int i = 0; i < widget.numberOfParticles; i++) {
      _particles.add(ConfettiParticle(
        color: _getRandomColor(),
        size: _random.nextDouble() * 10 + 5,
        x: _random.nextDouble(),
        y: _random.nextDouble() * 0.3,
        rotation: _random.nextDouble() * 2 * math.pi,
      ));
    }
  }

  Color _getRandomColor() {
    final colors = [
      const Color(0xFF7AA5E8),
      const Color(0xFF81C995),
      const Color(0xFFE89BB5),
      const Color(0xFFB49CDC),
      const Color(0xFFFFD97D),
      const Color(0xFFFFAA8A),
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void didUpdateWidget(CelebrationConfetti oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(
            particles: _particles,
            progress: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class ConfettiParticle {
  final Color color;
  final double size;
  final double x;
  final double y;
  final double rotation;

  ConfettiParticle({
    required this.color,
    required this.size,
    required this.x,
    required this.y,
    required this.rotation,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(1 - progress)
        ..style = PaintingStyle.fill;

      final x = particle.x * size.width;
      final y = particle.y * size.height + (progress * size.height * 1.2);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(particle.rotation + progress * 4 * math.pi);
      canvas.drawCircle(Offset.zero, particle.size, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
