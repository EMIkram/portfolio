import 'package:flutter/material.dart';

class PortfolioGrid extends CustomPainter {
  PortfolioGrid(this.color, {this.pointer}) : super(repaint: pointer);
  final Color color;
  final ValueNotifier<Offset?>? pointer;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = .6;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final center = pointer?.value;
    if (center == null) return;
    const radius = 160.0;
    final bounds = Rect.fromCircle(center: center, radius: radius);
    final glow = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xDD39FF88), Color(0x8039FF88), Color(0x0039FF88)],
        stops: [0, .35, 1],
      ).createShader(bounds)
      ..strokeWidth = 1.2;
    final lines = Path();
    for (double x = 0; x < size.width; x += 40) {
      if ((x - center.dx).abs() <= radius) {
        lines.moveTo(x, bounds.top);
        lines.lineTo(x, bounds.bottom);
      }
    }
    for (double y = 0; y < size.height; y += 40) {
      if ((y - center.dy).abs() <= radius) {
        lines.moveTo(bounds.left, y);
        lines.lineTo(bounds.right, y);
      }
    }
    glow.style = PaintingStyle.stroke;
    canvas.drawPath(
      lines,
      glow..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawPath(lines, glow..maskFilter = null);
  }

  @override
  bool shouldRepaint(PortfolioGrid oldDelegate) =>
      oldDelegate.color != color || oldDelegate.pointer != pointer;
}

class CapabilityPanel extends StatelessWidget {
  const CapabilityPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const groups = [
      (
        Icons.auto_awesome_outlined,
        'AI & engineering quality',
        'Agentic AI · Spec-driven development · TDD · Code review',
        'Structured planning, AI-assisted implementation, and test-driven development.',
      ),
      (
        Icons.devices_rounded,
        'Build across platforms',
        'Flutter mobile & web · Dart · iOS / Swift · UIKit · Firebase',
        'Production applications for Android, iOS, and the browser.',
      ),
      (
        Icons.account_tree_outlined,
        'Architecture & integrations',
        'BLoC / Cubit · Clean Architecture · REST APIs · JSON · SOLID',
        'Reusable foundations, secure networking, and maintainable code.',
      ),

      (
        Icons.rocket_launch_outlined,
        'Delivery & automation',
        'CI/CD · GitHub Actions · Jira · Kanban · Release management',
        'Connect implementation, QA handoffs, validation, and deployment.',
      ),
      (
        Icons.groups_outlined,
        'Leadership & coordination',
        'Mentoring · Feature planning · Priorities · Stakeholder collaboration',
        'Hands-on technical leadership with a strong interest in project management.',
      ),
      (
        Icons.storage_outlined,
        'Data & platform services',
        'Firestore · Notifications · Sqflite · CoreData · Async / streams',
        'Connected experiences with persistence and native platform integrations.',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ENGINEERING TOOLKIT',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'From implementation to delivery.',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in [
              (Icons.flutter_dash, 'Flutter'),
              (Icons.code, 'Dart'),
              (Icons.apple, 'iOS'),
              (Icons.local_fire_department, 'Firebase'),
              (Icons.sync, 'CI/CD'),
              (Icons.auto_awesome, 'Agentic AI'),
              (Icons.auto_awesome_outlined, 'LLM driven development'),
              (Icons.fact_check_outlined, 'TDD'),
            ])
              Chip(
                avatar: Icon(item.$1, size: 18, color: scheme.primary),
                label: Text(item.$2),
                backgroundColor: scheme.surface,
                side: BorderSide(color: scheme.outlineVariant),
              ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, bounds) {
            final cols = bounds.maxWidth > 1050
                ? 3
                : bounds.maxWidth > 620
                ? 2
                : 1;
            return Column(
              children: [
                for (var row = 0; row < groups.length; row += cols)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (
                            var index = row;
                            index < row + cols && index < groups.length;
                            index++
                          ) ...[
                            if (index > row) const SizedBox(width: 14),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  final group = groups[index];
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF242B3E)
                                          : const Color(0xFFE8EDF5),
                                      border: Border.all(
                                        color: scheme.outlineVariant.withValues(
                                          alpha: .55,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          group.$1,
                                          color: scheme.primary,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 14),
                                        Text(
                                          group.$2,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 9),
                                        Text(
                                          group.$3,
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1.7,
                                            color: scheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 9),
                                        Text(
                                          group.$4,
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1.6,
                                            color: scheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
