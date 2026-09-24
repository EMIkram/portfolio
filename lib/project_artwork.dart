import 'package:flutter/material.dart';
import 'portfolio_data.dart';
import 'screenshot_gallery.dart';

// Concept compositions communicate each product's domain without claiming to
// reproduce private interfaces or screenshots that were not supplied.
class ProjectArtwork extends StatelessWidget {
  const ProjectArtwork({
    super.key,
    required this.project,
    this.compact = false,
  });
  final Project project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (project.screens.isNotEmpty) {
      return ScreenshotComposition(project: project);
    }
    final desktop = project.name == 'Carbee';
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -75,
                top: -80,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .4),
                      width: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -70,
                bottom: -160,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .23),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 22,
                child: Text(
                  desktop
                      ? 'BUILT FOR THE BIG PICTURE'
                      : 'SMALL SCREEN. REAL IMPACT.',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 2,
                    color: const Color(0xFF22232B).withValues(alpha: .5),
                  ),
                ),
              ),
              Positioned.fill(
                top: 38,
                bottom: 25,
                left: 25,
                right: 25,
                child: FittedBox(
                  child: SizedBox(
                    width: desktop ? 520 : 400,
                    height: 470,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!desktop)
                          Positioned(
                            right: 28,
                            top: 38,
                            child: Transform.rotate(
                              angle: .12,
                              child: _phone(secondary: true),
                            ),
                          ),
                        Transform.rotate(
                          angle: desktop ? -.04 : -.08,
                          child: desktop ? _browser() : _phone(),
                        ),
                        Positioned(
                          left: desktop ? 4 : 0,
                          bottom: 35,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .08),
                                  blurRadius: 25,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  project.icon,
                                  size: 20,
                                  color: const Color(0xFF6C4DCE),
                                ),
                                const SizedBox(width: 9),
                                Text(
                                  project.tags.first,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 14,
                child: Text(
                  'ILLUSTRATIVE UI',
                  style: TextStyle(
                    fontSize: 8,
                    letterSpacing: 1.5,
                    color: Colors.black.withValues(alpha: .4),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _phone({bool secondary = false}) {
    final ai = project.name == 'Afterlife AI';
    final dark = ai && !secondary;
    final ink = dark ? Colors.white : const Color(0xFF242633);
    return Container(
      width: 176,
      height: 420,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFF24252C),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF25203C).withValues(alpha: .23),
            blurRadius: 30,
            offset: const Offset(10, 22),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ColoredBox(
          color: dark ? const Color(0xFF28213F) : const Color(0xFFFEFEFA),
          child: Column(
            children: [
              const SizedBox(height: 7),
              Container(
                width: 48,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF24252C),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 16, 13, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Icon(Icons.more_horiz, size: 16, color: ink),
                  ],
                ),
              ),
              if (secondary) ...[
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Text(
                    'Made for\nevery day.',
                    style: TextStyle(
                      fontSize: 24,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      color: ink,
                    ),
                  ),
                ),
                for (var i = 0; i < 3; i++) _miniRow(i, ink),
              ] else ...[
                Container(
                  height: 95,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: project.color.withValues(alpha: dark ? .15 : .7),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(
                    child: Icon(
                      project.icon,
                      size: 49,
                      color: dark
                          ? const Color(0xFFD6C0FF)
                          : const Color(0xFF535D57),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 5,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _headline,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                        color: ink,
                      ),
                    ),
                  ),
                ),
                _miniRow(0, ink),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 5,
                  ),
                  height: 29,
                  decoration: BoxDecoration(
                    color: dark
                        ? const Color(0xFFAB8DEF)
                        : const Color(0xFF343B37),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      _action,
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
              ],
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.home_rounded, size: 15, color: ink),
                    Icon(
                      Icons.search,
                      size: 15,
                      color: ink.withValues(alpha: .4),
                    ),
                    Icon(
                      Icons.person_outline,
                      size: 15,
                      color: ink.withValues(alpha: .4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _headline => switch (project.name) {
    'Dr.iQ' => 'Your health,\nyour space.',
    'Afterlife AI' => 'A new kind of\nconversation.',
    'Invoice Labs' => 'Business,\nbeautifully simple.',
    'Muslim World 360' => 'Pause. Reflect.\nReconnect.',
    _ => 'Good food starts\nwith knowing.',
  };
  String get _action => switch (project.name) {
    'Dr.iQ' => 'Start a consultation',
    'Afterlife AI' => 'Explore avatars',
    'Invoice Labs' => 'Create an invoice',
    'Muslim World 360' => 'Explore Quran',
    _ => 'Discover ingredients',
  };

  Widget _miniRow(int index, Color ink) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
    child: Row(
      children: [
        Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            color: project.color.withValues(alpha: .5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            index == 0 ? Icons.check_rounded : Icons.bookmark_outline,
            size: 12,
            color: ink,
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4,
                width: 70,
                color: ink.withValues(alpha: .35),
              ),
              const SizedBox(height: 5),
              Container(
                height: 3,
                width: 46,
                color: ink.withValues(alpha: .12),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _browser() => Container(
    width: 470,
    height: 330,
    decoration: BoxDecoration(
      color: const Color(0xFFFCFCFE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white, width: 5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF334A76).withValues(alpha: .22),
          blurRadius: 30,
          offset: const Offset(10, 20),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F1F5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                ),
              const Spacer(),
              const Text(
                'carbee / dealership',
                style: TextStyle(fontSize: 8, color: Colors.black45),
              ),
              const Spacer(),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 110,
                padding: const EdgeInsets.all(12),
                color: const Color(0xFF24293C),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'carbee.',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 27),
                    for (final label in [
                      'Overview',
                      'Inventory',
                      'Enquiries',
                      'Dealership',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your dealership, at a glance',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Everything you need. One workspace.',
                        style: TextStyle(fontSize: 8, color: Colors.black45),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          for (final label in [
                            'Inventory',
                            'Enquiries',
                            'Activity',
                          ])
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: project.color.withValues(alpha: .45),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      label,
                                      style: const TextStyle(fontSize: 8),
                                    ),
                                    const SizedBox(height: 8),
                                    const Icon(
                                      Icons.bar_chart_rounded,
                                      size: 22,
                                      color: Color(0xFF617AAF),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Vehicle collection',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            for (var i = 0; i < 3; i++)
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F2F7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.directions_car_filled_rounded,
                                    size: 44,
                                    color: [
                                      const Color(0xFF627796),
                                      const Color(0xFF555965),
                                      const Color(0xFF9BA4B2),
                                    ][i],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
