import 'package:flutter/material.dart';
import 'portfolio_data.dart';

class ScreenshotComposition extends StatelessWidget {
  const ScreenshotComposition({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned(
            right: -60,
            top: -100,
            child: Container(
              width: 310,
              height: 310,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .3),
              ),
            ),
          ),
          Positioned.fill(
            left: 12,
            right: 12,
            top: 20,
            bottom: 20,
            child: FittedBox(
              child: SizedBox(
                width: 620,
                height: 440,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 3,
                      width: 430,
                      child: Transform.rotate(
                        angle: .075,
                        child: BrowserFrame(screen: project.screens[2]),
                      ),
                    ),
                    Positioned(
                      left: 4,
                      top: 114,
                      width: 480,
                      child: Transform.rotate(
                        angle: -.055,
                        child: BrowserFrame(screen: project.screens.first),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF171719),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.layers_outlined,
                              color: Color(0xFFFFC229),
                              size: 22,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'One product.\nAn entire ecosystem.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.4,
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
        ],
      ),
    ),
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
          Image.asset(
            screen.$2,
            fit: BoxFit.contain,
            semanticLabel: screen.$1,
            errorBuilder: (context, error, stack) => const SizedBox(
              height: 170,
              child: Center(child: Text('Preview unavailable')),
            ),
          ),
        ],
      ),
    ),
  );
}

class ScreenshotGallery extends StatefulWidget {
  const ScreenshotGallery({super.key, required this.project});
  final Project project;
  @override
  State<ScreenshotGallery> createState() => _ScreenshotGalleryState();
}

class _ScreenshotGalleryState extends State<ScreenshotGallery> {
  int _selected = 0;
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
          child: BrowserFrame(screen: widget.project.screens[_selected]),
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
                  child: Image.asset(
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
