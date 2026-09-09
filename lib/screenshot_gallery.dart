import 'package:flutter/material.dart';
import 'portfolio_data.dart';

class ScreenshotComposition extends StatelessWidget {
  const ScreenshotComposition({super.key, required this.project});
  final Project project;

  Widget _screen(int i) {
    final screen = project.screens[i];
    if (project.name == 'Dr.iQ' && (i == 1 || i == 2)) {
      return FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 193,
          height: 423,
          child: ClipRect(
            child: Stack(
              children: [
                Positioned(
                  left: -75,
                  top: -137,
                  width: 340,
                  height: 605,
                  child: ScreenshotImage(
                    screen.$2,
                    fit: BoxFit.fill,
                    semanticLabel: screen.$1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ScreenshotImage(
      screen.$2,
      fit: BoxFit.contain,
      semanticLabel: screen.$1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final features = switch (project.name) {
      'Carbee' => [
        'Customer & dealer apps',
        'Admin & dealership portals',
        'Shared design foundations',
      ],
      'Dr.iQ' => ['Online consultations', 'Appointments', 'Repeat medication'],
      'Carpool' => [
        'Find shared journeys',
        'Offer available seats',
        'Manage ride requests',
      ],
      'Ayuda Health' => [
        'Health readings',
        'Medication reminders',
        'Symptom diaries',
      ],
      'My Treats' => ['Browse the menu', 'Place an order', 'Delivery journeys'],
      'LSUK' => ['Interpreter jobs', 'Timesheets', 'Service workflows'],
      _ => ['Ingredient discovery', 'Search & browse', 'Mobile experience'],
    };
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, bounds) {
          final wide = bounds.maxWidth > 620 && bounds.maxHeight >= 230;
          final art = project.mobile
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final i
                        in (project.name == 'Dr.iQ' ? [3, 0, 4] : [0, 1]))
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: PhonePreview(child: _screen(i)),
                        ),
                      ),
                  ],
                )
              : FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 900,
                    height: 500,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          width: 610,
                          child: BrowserFrame(screen: project.screens[0]),
                        ),
                        Positioned(
                          left: 0,
                          top: 330,
                          width: 298,
                          child: BrowserFrame(screen: project.screens[2]),
                        ),
                        Positioned(
                          left: 312,
                          top: 330,
                          width: 298,
                          child: BrowserFrame(screen: project.screens[21]),
                        ),
                        Positioned(
                          left: 635,
                          top: 70,
                          width: 122,
                          height: 282,
                          child: PhonePreview(child: _screen(6)),
                        ),
                        Positioned(
                          left: 774,
                          top: 70,
                          width: 122,
                          height: 282,
                          child: PhonePreview(child: _screen(7)),
                        ),
                        const Positioned(
                          left: 635,
                          top: 372,
                          width: 261,
                          child: Text(
                            'Customer & dealer mobile',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
          if (!wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  features.take(2).join('  /  '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(child: art),
              ],
            );
          }
          return Row(
            children: [
              SizedBox(
                width: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.2,
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      project.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 18),
                    for (final feature in features)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: scheme.primary,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                feature,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(child: art),
            ],
          );
        },
      ),
    );
  }
}

class CarbeeScreenWall extends StatelessWidget {
  const CarbeeScreenWall({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = constraints.maxWidth > 850 ? 4 : 2;
      // Interleave customer journeys, dealer tools, and platform foundations.
      const order = [
        21,
        22,
        23,
        24,
        17,
        1,
        7,
        8,
        0,
        20,
        2,
        19,
        10,
        5,
        6,
        3,
        18,
        11,
        9,
        4,
        14,
        15,
        16,
        13,
        12,
      ];
      return ExpansionTile(
        key: const PageStorageKey('carbee-collection'),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        childrenPadding: const EdgeInsets.only(top: 20),
        title: const Text(
          'A closer look at Carbee',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${project.screens.length} screens · Customer app, dealer app, portals & design system',
          style: const TextStyle(color: Color(0xFF74736F), height: 1.6),
        ),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var column = 0; column < columns; column++) ...[
                if (column > 0) const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        for (
                          var position = column;
                          position < order.length;
                          position += columns
                        )
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Transform.rotate(
                              angle: 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => showDialog<void>(
                                  context: context,
                                  builder: (dialogContext) => Dialog(
                                    insetPadding: const EdgeInsets.all(18),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 760,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  tooltip: 'Close collection',
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                        dialogContext,
                                                      ),
                                                  icon: const Icon(Icons.close),
                                                ),
                                              ),
                                              ScreenshotGallery(
                                                project: project,
                                                initialIndex: order[position],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0EEE7),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: const Color(0xFFDEDDD7),
                                        ),
                                      ),
                                      child:
                                          project.screens[order[position]].$1
                                              .contains('mobile')
                                          ? SizedBox(
                                              height: columns == 4 ? 310 : 250,
                                              width: double.infinity,
                                              child: ScreenshotImage(
                                                project
                                                    .screens[order[position]]
                                                    .$2,
                                                fit: BoxFit.contain,
                                                semanticLabel: project
                                                    .screens[order[position]]
                                                    .$1,
                                              ),
                                            )
                                          : BrowserFrame(
                                              screen: project
                                                  .screens[order[position]],
                                            ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${project.screens[order[position]].$1} ↗',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF74736F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      );
    },
  );
}

class BrowserFrame extends StatelessWidget {
  const BrowserFrame({super.key, required this.screen});
  final (String, String) screen;
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .20),
          blurRadius: 24,
          offset: const Offset(0, 16),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 27,
            color: const Color(0xFF232326),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                for (final color in [
                  const Color(0xFFF4837A),
                  const Color(0xFFFFCF69),
                  const Color(0xFF8CCD9B),
                ])
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    screen.$1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
          ScreenshotImage(
            screen.$2,
            fit: BoxFit.contain,
            semanticLabel: screen.$1,
          ),
        ],
      ),
    ),
  );
}

class ScreenshotGallery extends StatefulWidget {
  const ScreenshotGallery({
    super.key,
    required this.project,
    this.initialIndex = 0,
  });
  final Project project;
  final int initialIndex;
  @override
  State<ScreenshotGallery> createState() => _ScreenshotGalleryState();
}

class _ScreenshotGalleryState extends State<ScreenshotGallery> {
  late int _selected = widget.initialIndex;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'A closer look',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (var i = 0; i < widget.project.screens.length; i++)
            ChoiceChip(
              label: Text(widget.project.screens[i].$1),
              selected: i == _selected,
              onSelected: (_) => setState(() => _selected = i),
            ),
        ],
      ),
      const SizedBox(height: 18),
      AnimatedSwitcher(
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 250),
        child: InkWell(
          key: ValueKey(_selected),
          onTap: () => _expand(context),
          child:
              widget.project.mobile ||
                  widget.project.screens[_selected].$1.contains('mobile')
              ? SizedBox(
                  height: 420,
                  width: double.infinity,
                  child: ScreenshotImage(
                    widget.project.screens[_selected].$2,
                    fit: BoxFit.contain,
                    semanticLabel: widget.project.screens[_selected].$1,
                  ),
                )
              : BrowserFrame(screen: widget.project.screens[_selected]),
        ),
      ),
      const SizedBox(height: 12),
      TextButton.icon(
        onPressed: () => _expand(context),
        icon: const Icon(Icons.zoom_in, size: 18),
        label: const Text('Expand screenshot'),
      ),
    ],
  );

  void _expand(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: const Color(0xFF1B1B1E),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.project.screens[_selected].$1,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close screenshot',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InteractiveViewer(
                minScale: .5,
                maxScale: 5,
                child: Center(
                  child: ScreenshotImage(
                    widget.project.screens[_selected].$2,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Pinch or scroll to zoom · Drag to explore',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Keeps loading and failed requests distinct, and allows a failed asset to retry.
class ScreenshotImage extends StatefulWidget {
  const ScreenshotImage(this.path, {super.key, this.fit, this.semanticLabel});
  final String path;
  final BoxFit? fit;
  final String? semanticLabel;
  @override
  State<ScreenshotImage> createState() => _ScreenshotImageState();
}

class _ScreenshotImageState extends State<ScreenshotImage> {
  int _attempt = 0;
  Future<void> _retry() async {
    await AssetImage(widget.path).evict();
    if (mounted) setState(() => _attempt++);
  }

  @override
  Widget build(BuildContext context) => Image.asset(
    widget.path,
    key: ValueKey('${widget.path}:$_attempt'),
    fit: widget.fit,
    filterQuality: FilterQuality.high,
    semanticLabel: widget.semanticLabel,
    frameBuilder: (context, child, frame, synchronous) =>
        frame != null || synchronous
        ? child
        : const SizedBox(
            height: 170,
            child: Center(
              child: Text(
                'Loading screenshot...',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
          ),
    errorBuilder: (context, error, stack) => SizedBox(
      height: 170,
      child: Center(
        child: TextButton.icon(
          onPressed: _retry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry screenshot'),
        ),
      ),
    ),
  );
}

class PhonePreview extends StatelessWidget {
  const PhonePreview({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: .46,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF20212A),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: ColoredBox(color: Colors.white, child: child),
      ),
    ),
  );
}
