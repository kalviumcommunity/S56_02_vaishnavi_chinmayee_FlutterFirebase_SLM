import 'package:flutter/material.dart';
import '../core/theme.dart';

class AnimatedStatCard extends StatefulWidget {
  final String title;
  final int value;
  final IconData icon;

  const AnimatedStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,

      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Column(
            children: [
              Icon(widget.icon, color: AppColors.primary),

              const SizedBox(height: 10),

              Text(
                animation.value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(widget.title),
            ],
          ),
        );
      },
    );
  }
}
