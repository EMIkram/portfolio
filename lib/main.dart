import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'portfolio_data.dart';
import 'github_icon.dart';
import 'portfolio_visuals.dart';
import 'project_artwork.dart';
import 'screenshot_gallery.dart';
import 'external_link.dart'
    if (dart.library.js_interop) 'external_link_web.dart';

const ink = Color(0xFF25252A);
const paper = Color(0xFFF7F8FC);
const violet = Color(0xFF7150CF);
const muted = Color(0xFF74736F);

const resumeUrl = String.fromEnvironment(
  'RESUME_URL',
  defaultValue:
      'https://drive.google.com/file/d/10GP3VnKlMdyDxZknQBZbJivAEX3EqwNl/view?usp=sharing',
);

void main() => runApp(const MyApp());

void showProjectLinks(
  BuildContext context,
  String name, {
  String? fallback,
  String? description,
  IconData fallbackIcon = Icons.apps_rounded,
}) {
  final links =
      projectLinks[name] ??
      (fallback == null ? <(String, String)>[] : [('Visit project', fallback)]);
  void open(String url) {
    if (!openExternalLink(url)) {
      Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Project link copied')));
    }
  }

  if (links.length == 1 && description == null) {
    open(links.first.$2);
    return;
  }
  showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.all(22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF25252A), Color(0xFF423952)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: 68,
                            height: 68,
                            color: Colors.white,
                            child: projectIcons[name] == null
                                ? Icon(fallbackIcon, color: violet, size: 32)
                                : Image.asset(
                                    projectIcons[name]!,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'PROJECT DIRECTORY',
                      style: TextStyle(
                        color: Color(0xFFD0BDFF),
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore $name',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      description ??
                          'Choose where you’d like to explore this product.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.6,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (final link in links)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.pop(dialogContext);
                              open(link.$2);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0EBFA),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      link.$1 == 'App Store'
                                          ? Icons.apple
                                          : link.$1 == 'Google Play'
                                          ? Icons.android
                                          : Icons.language,
                                      color: violet,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          link.$1,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          link.$1 == 'App Store'
                                              ? 'View the iOS app'
                                              : link.$1 == 'Google Play'
                                              ? 'View the Android app'
                                              : 'Visit the official site',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.north_east,
                                    size: 18,
                                    color: violet,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ProjectIcon extends StatelessWidget {
  const ProjectIcon({
    super.key,
    required this.name,
    required this.fallback,
    this.size = 44,
    this.link,
  });
  final String name;
  final IconData fallback;
  final double size;
  final String? link;
  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Explore $name',
    child: InkWell(
      onTap: projectLinks.containsKey(name) || link != null
          ? () => showProjectLinks(context, name, fallback: link)
          : null,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size,
          height: size,
          color: Colors.white,
          child: projectIcons[name] != null
              ? Image.asset(
                  projectIcons[name]!,
                  fit: BoxFit.contain,
                  semanticLabel: '$name app icon',
                )
              : Icon(fallback, size: size * .55, color: violet),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _mode = ThemeMode.light;
  ThemeData _theme(Brightness brightness) => ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: brightness == Brightness.dark
        ? const Color(0xFF151619)
        : paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: violet,
      brightness: brightness,
      surface: brightness == Brightness.dark ? const Color(0xFF151619) : paper,
    ),
    fontFamily: 'Arial',
    visualDensity: VisualDensity.compact,
  );
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ikram Ul Haq — Flutter & iOS Developer',
    debugShowCheckedModeBanner: false,
    theme: _theme(Brightness.light),
    darkTheme: _theme(Brightness.dark),
    themeMode: _mode,
    home: PortfolioPage(
      onToggleTheme: () => setState(() {
        _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      }),
    ),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, this.onToggleTheme});
  final VoidCallback? onToggleTheme;
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();
  final _work = GlobalKey();
  final _about = GlobalKey();
  bool _compactHeader = false;
  final _gridPointer = ValueNotifier<Offset?>(null);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_updateHeader);
  }

  void _updateHeader() {
    final compact = _scroll.offset > (_compactHeader ? 24 : 100);
    if (compact != _compactHeader) setState(() => _compactHeader = compact);
  }

  @override
  void dispose() {
    _gridPointer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _go(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: MouseRegion(
      onHover: (event) => _gridPointer.value = event.localPosition,
      onExit: (_) => _gridPointer.value = null,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: PortfolioGrid(
                Theme.of(context).colorScheme.primary.withValues(alpha: .065),
                pointer: _gridPointer,
              ),
              child: SelectionArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth >= 850;
                    final padding = wide ? 32.0 : 18.0;
                    return Scrollbar(
                      controller: _scroll,
                      child: SingleChildScrollView(
                        controller: _scroll,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1480),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: padding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: constraints.maxWidth < 700
                                        ? 170
                                        : 100,
                                  ),
                                  _hero(wide),
                                  const SizedBox(height: 36),
                                  _sectionLabel(
                                    '01 / SELECTED WORK',
                                    'A few things I’ve helped bring to life.',
                                    key: _work,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Selected products. Real-world impact.',
                                    style: TextStyle(
                                      fontSize: wide ? 32 : 28,
                                      height: 1.07,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'Web platforms, shared journeys, and everyday healthcare.\nA selection of the products I’ve helped build.',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      fontSize: 16,
                                      height: 1.7,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  _project(2, 280),
                                  const SizedBox(height: 32),
                                  _project(0, wide ? 440 : 330),
                                  const SizedBox(height: 32),
                                  CarbeeScreenWall(project: projects.first),
                                  const SizedBox(height: 36),
                                  LayoutBuilder(
                                    builder: (context, bounds) {
                                      final columns = bounds.maxWidth >= 1100
                                          ? 3
                                          : bounds.maxWidth >= 650
                                          ? 2
                                          : 1;
                                      final width =
                                          (bounds.maxWidth -
                                              (columns - 1) * 24) /
                                          columns;
                                      return Wrap(
                                        spacing: 24,
                                        runSpacing: 32,
                                        children: [
                                          for (final i in [1, 3, 4, 5, 6])
                                            SizedBox(
                                              width: width,
                                              child: _project(i, 270),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 36),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 28,
                                    ),
                                    child: Text(
                                      'MORE WORLDS I’VE WORKED IN',
                                      style: _eyebrow,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 14,
                                    children: [
                                      for (final p in additionalProjects)
                                        ActionChip(
                                          avatar: ProjectIcon(
                                            name: p.$1,
                                            fallback: p.$3,
                                            size: 32,
                                          ),
                                          label: Text(p.$1),
                                          backgroundColor: Colors.transparent,
                                          side: const BorderSide(
                                            color: Color(0xFFDEDDD7),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          onPressed: () => showProjectLinks(
                                            context,
                                            p.$1,
                                            description: p.$2,
                                            fallbackIcon: p.$3,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 60),
                                  _aboutSection(wide),
                                  const SizedBox(height: 60),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 45,
                                      runSpacing: 12,
                                      children: [
                                        Text(
                                          '© Muhammad Ikram Ul Haq',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        Text(
                                          'Built with Flutter. Made with intention.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => _scroll.animateTo(
                                            0,
                                            duration:
                                                MediaQuery.disableAnimationsOf(
                                                  context,
                                                )
                                                ? Duration.zero
                                                : const Duration(
                                                    milliseconds: 700,
                                                  ),
                                            curve: Curves.easeInOut,
                                          ),
                                          child: const Text('Back to top ↑'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 18,
            right: 18,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedContainer(
                  key: const ValueKey('header-shell'),
                  duration: MediaQuery.disableAnimationsOf(context)
                      ? Duration.zero
                      : const Duration(milliseconds: 320),
                  curve: Curves.easeInOutCubic,
                  margin: EdgeInsets.symmetric(
                    vertical: _compactHeader ? 2 : 8,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: _compactHeader ? 2 : 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(
                      _compactHeader ? 26 : 20,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AnimatedSize(
                    duration: MediaQuery.disableAnimationsOf(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 320),
                    curve: Curves.easeInOutCubic,
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: MediaQuery.disableAnimationsOf(context)
                          ? Duration.zero
                          : const Duration(milliseconds: 160),
                      layoutBuilder: (currentChild, previousChildren) => Stack(
                        alignment: Alignment.center,
                        children: [
                          for (final child in previousChildren)
                            Positioned.fill(child: IgnorePointer(child: child)),
                          ?currentChild,
                        ],
                      ),
                      child: _nav(MediaQuery.sizeOf(context).width >= 1100),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  TextStyle get _eyebrow => TextStyle(
    fontSize: 10,
    letterSpacing: 2,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  void _openContact(String url) {
    if (!openExternalLink(url)) _copy(context, url, 'Contact link copied');
  }

  Widget _nav(bool wide) => Container(
    key: ValueKey(_compactHeader ? 'compact-header' : 'expanded-header'),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: _compactHeader ? 14 : 18,
              backgroundImage: const AssetImage('assets/images/ikram.png'),
            ),
            if (!_compactHeader) const SizedBox(width: 10),
            if (!_compactHeader)
              const Text(
                'ikram ul haq.',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 2,
          children: [
            if (!_compactHeader)
              TextButton(
                onPressed: () => _go(_work),
                child: const Text('Work'),
              ),
            if (!_compactHeader)
              TextButton(
                onPressed: () => _go(_about),
                child: const Text('About'),
              ),
            if (_compactHeader)
              IconButton(
                tooltip: 'Download resume',
                onPressed: () => _openContact(resumeUrl),
                icon: const Icon(Icons.download_outlined, size: 19),
              )
            else
              TextButton.icon(
                onPressed: () => _openContact(resumeUrl),
                icon: const Icon(Icons.download_outlined, size: 18),
                label: const Text('Download resume'),
              ),
            Tooltip(
              message: 'Email',
              child: _compactHeader
                  ? IconButton(
                      onPressed: () =>
                          _openContact('mailto:emikramulhaq@gmail.com'),
                      icon: const Icon(Icons.mail_outline, size: 19),
                    )
                  : TextButton.icon(
                      onPressed: () =>
                          _openContact('mailto:emikramulhaq@gmail.com'),
                      icon: const Icon(Icons.mail_outline, size: 19),
                      label: Text(wide ? 'emikramulhaq@gmail.com' : 'Email'),
                    ),
            ),
            IconButton(
              tooltip: '+92 309 525 1250',
              onPressed: () => _openContact('tel:+923095251250'),
              icon: const Icon(Icons.phone_outlined, size: 19),
            ),
            IconButton(
              tooltip: 'GitHub',
              onPressed: () => _openContact('https://github.com/EMIkram'),
              icon: const GitHubIcon(),
            ),
            IconButton(
              tooltip: 'LinkedIn',
              onPressed: () => _openContact(
                'https://www.linkedin.com/in/muhammad-ikram-ulhaq-a718a9145/',
              ),
              icon: Container(
                width: 19,
                height: 19,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'in',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    height: 1,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: Theme.of(context).brightness == Brightness.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
              onPressed: widget.onToggleTheme,
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 19,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _hero(bool wide) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SENIOR SOFTWARE ENGINEER · TECH LEAD · AI-NATIVE DEVELOPMENT',
          style: _eyebrow,
        ),
        const SizedBox(height: 25),
        Text(
          'Muhammad\nIkram Ul Haq.',
          style: TextStyle(
            fontSize: wide ? 46 : 36,
            height: 1.03,
            letterSpacing: 0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Thoughtful software.\nConfident delivery.',
          style: TextStyle(
            fontSize: wide ? 22 : 20,
            height: 1.3,
            letterSpacing: 0,
            color: violet,
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 470),
          child: Text(
            'I’m a Senior Software Engineer and Tech Lead, building mobile and web products. With 5+ years in engineering and 3+ years leading teams, I connect hands-on implementation, architecture, and delivery. AI-assisted and agentic development are part of my daily workflow—from planning and implementation to testing and review. I also bring technical leadership and delivery planning to the work. With AI and focused R&D, I’m confident adapting to new technologies and languages.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton(
              onPressed: () => _go(_work),
              style: FilledButton.styleFrom(
                backgroundColor: ink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 22,
                ),
              ),
              child: const Text('View selected work ↘'),
            ),
          ],
        ),
        const SizedBox(height: 35),
        Text(
          'ISLAMABAD, PAKISTAN  /  MOBILE & WEB',
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 1.7,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    final portrait = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/ikram.png',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ikram Ul Haq',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Engineering with ownership',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (final item in [
            ('5+', 'Years in software engineering'),
            ('3+', 'Years leading teams'),
            ('15+', 'Apps built & contributed to'),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      item.$1,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(item.$2, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          const Divider(),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.circle, size: 8, color: Color(0xFF008557)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Islamabad · On-site, hybrid & remote',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4),
            child: Text(
              'Available for immediate joining',
              style: TextStyle(fontSize: 8),
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: wide ? 24 : 16, bottom: 25),
      child: Column(
        children: [
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 65),
                SizedBox(width: 310, child: portrait),
              ],
            )
          else ...[
            intro,
            const SizedBox(height: 35),
            SizedBox(width: 310, child: portrait),
          ],
          const SizedBox(height: 40),
          const CapabilityPanel(),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label, String trailing, {Key? key}) => SizedBox(
    key: key,
    width: double.infinity,
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 15,
      runSpacing: 10,
      children: [
        Text(label, style: _eyebrow),
        Text(
          trailing,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );

  Widget _project(int index, double height) => ProjectTile(
    project: projects[index],
    index: index,
    height: height,
    scroll: _scroll,
    onTap: () => _showProject(projects[index]),
  );

  void _showProject(Project project) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(22),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: 285,
                    color: project.color,
                    child: ProjectArtwork(project: project),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton.filledTonal(
                      tooltip: 'Close project',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.category, style: _eyebrow),
                    const SizedBox(height: 10),
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'My contribution',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.contribution,
                      style: const TextStyle(fontSize: 15, height: 1.7),
                    ),
                    const SizedBox(height: 20),
                    if (project.highlights.isNotEmpty) ...[
                      const Text(
                        'Inside the product',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final highlight in project.highlights)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                highlight.$1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                highlight.$2,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                    if (project.screens.isNotEmpty) ...[
                      ScreenshotGallery(project: project),
                      const SizedBox(height: 20),
                    ],
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in project.tags) Chip(label: Text(tag)),
                      ],
                    ),
                    if (project.link != null) ...[
                      const SizedBox(height: 18),
                      FilledButton.icon(
                        onPressed: () => showProjectLinks(
                          context,
                          project.name,
                          fallback: project.link,
                        ),
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: Text(
                          project.name == 'Carpool'
                              ? 'View on Google Play'
                              : 'Visit project',
                        ),
                      ),
                      const SizedBox(height: 12),
                      SelectableText(project.link!),
                      TextButton.icon(
                        onPressed: () => _copy(
                          context,
                          project.link!,
                          'Project link copied',
                        ),
                        icon: const Icon(Icons.copy, size: 16),
                        label: const Text('Copy project link'),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text(
                      project.source ??
                          'Product screenshots presented in portfolio mockups.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _aboutSection(bool wide) {
    final story = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A developer’s mind.\nA craftsperson’s care.',
          style: TextStyle(
            fontSize: wide ? 32 : 28,
            letterSpacing: 0,
            height: 1.12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'I’m Muhammad Ikram Ul Haq, a Flutter developer with native iOS experience. I’ve independently completed several projects from start to finish and led teams to deliver several more. Across startups, product teams, and service companies, I bring hands-on engineering and the leadership to help teams ship with confidence.',
          style: TextStyle(
            fontSize: 16,
            height: 1.8,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'My focus is clean architecture, intuitive interfaces, and the engineering behind them: reliable integrations, maintainable code, and thoughtful release workflows.',
          style: TextStyle(
            fontSize: 16,
            height: 1.8,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'BS Computer Science · Federal Urdu University\n2016–2020 · CGPA 3.59',
          style: TextStyle(
            fontSize: 12,
            height: 1.8,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    final experience = Column(
      children: [
        for (final role in [
          (
            'Techtronix',
            'Tech Lead — Flutter & Mobile/Web Engineering',
            'MAR 2024 — PRESENT',
            'assets/images/company-techtronix.png',
          ),
          (
            'AT-Tech',
            'Software Engineer · Flutter & iOS',
            'JUN 2022 — MAR 2024',
            'assets/images/company-attech.png',
          ),
          (
            'Heuristify',
            'Flutter Developer',
            'JAN 2022 — JUN 2022',
            'assets/images/company-heuristify.png',
          ),
          (
            'SBS',
            'Associate Software Engineer',
            'NOV 2020 — JAN 2022',
            'assets/images/company-sbs.png',
          ),
          (
            'Independent',
            'Independent projects · Freelance developer',
            'AUG 2019 — SEP 2020',
            'assets/images/ikram.png',
          ),
        ])
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 21),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFDEDDD7))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.white,
                    child: Image.asset(
                      role.$4,
                      fit: role.$1 == 'Independent'
                          ? BoxFit.cover
                          : BoxFit.contain,
                      semanticLabel:
                          '${role.$1} ${role.$1 == 'Independent' ? 'portrait' : 'logo'}',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role.$3,
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.1,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        role.$1,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role.$2,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(
          '02 / A LITTLE ABOUT ME',
          'The person behind the pixels.',
          key: _about,
        ),
        const SizedBox(height: 35),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: story),
              const SizedBox(width: 95),
              Expanded(child: experience),
            ],
          )
        else ...[
          story,
          const SizedBox(height: 25),
          experience,
        ],
      ],
    );
  }
}

Future<void> _copy(BuildContext context, String value, String message) async {
  try {
    await Clipboard.setData(ClipboardData(text: value));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not copy. Select and copy the text manually.'),
        ),
      );
    }
  }
}

class ProjectTile extends StatefulWidget {
  const ProjectTile({
    super.key,
    required this.project,
    required this.index,
    required this.height,
    required this.scroll,
    required this.onTap,
  });
  final Project project;
  final int index;
  final double height;
  final ScrollController scroll;
  final VoidCallback onTap;
  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  final _anchor = GlobalKey();
  bool _hovered = false;
  double _shift = 0;
  double _reveal = 1;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    widget.scroll.addListener(_update);
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
  }

  @override
  void dispose() {
    widget.scroll.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (!mounted) return;
    final box = _anchor.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final viewport = MediaQuery.sizeOf(context).height;
    final y = box.localToGlobal(Offset.zero).dy;
    final progress = ((viewport - y) / (viewport + box.size.height)).clamp(
      0.0,
      1.0,
    );
    final shift = _reduceMotion ? 0.0 : (progress - .5) * 36;
    final reveal = _reduceMotion ? 1.0 : ((viewport - y) / 140).clamp(0.0, 1.0);
    if ((_shift - shift).abs() > .3 || (_reveal - reveal).abs() > .01) {
      setState(() {
        _shift = shift;
        _reveal = reveal;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    key: _anchor,
    child: Opacity(
      opacity: .15 + .85 * _reveal,
      child: Transform.translate(
        offset: Offset(0, (1 - _reveal) * 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: Material(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF292541)
                    : const Color(0xFFE5E0F4),
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: widget.onTap,
                  onFocusChange: (value) => setState(() => _hovered = value),
                  child: Semantics(
                    label: 'View ${widget.project.name} project details',
                    button: true,
                    child: SizedBox(
                      height: widget.height,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AnimatedScale(
                              scale: 1,
                              duration: _reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                              child: Transform.translate(
                                offset: Offset.zero,
                                child: ProjectArtwork(project: widget.project),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 17,
                            top: 17,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                color: _hovered
                                    ? ink
                                    : Colors.white.withValues(alpha: .7),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.north_east,
                                size: 17,
                                color: _hovered ? paper : ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                ProjectIcon(
                  name: widget.project.name,
                  fallback: widget.project.icon,
                  link: widget.project.link,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.project.name,
                    style: const TextStyle(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (final link
                    in projectLinks[widget.project.name] ??
                        [
                          (
                            widget.project.link?.contains('apps.apple.com') ??
                                    false
                                ? 'App Store'
                                : 'Website',
                            widget.project.link ?? '',
                          ),
                        ])
                  if (link.$2.isNotEmpty)
                    IconButton(
                      tooltip: '${widget.project.name} · ${link.$1}',
                      onPressed: () {
                        if (!openExternalLink(link.$2)) {
                          _copy(context, link.$2, 'Project link copied');
                        }
                      },
                      icon: Icon(
                        link.$1 == 'App Store'
                            ? Icons.apple
                            : link.$1 == 'Google Play'
                            ? Icons.play_arrow_rounded
                            : Icons.language,
                        size: 20,
                      ),
                    ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.project.summary,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.category,
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.6,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
