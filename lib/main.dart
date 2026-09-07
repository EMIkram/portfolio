import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'portfolio_data.dart';
import 'project_artwork.dart';
import 'screenshot_gallery.dart';
import 'external_link.dart'
    if (dart.library.js_interop) 'external_link_web.dart';

const ink = Color(0xFF25252A);
const paper = Color(0xFFF8F7F3);
const violet = Color(0xFF7150CF);
const muted = Color(0xFF74736F);

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
      backgroundColor: paper,
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
                      style: const TextStyle(
                        color: muted,
                        height: 1.6,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (final link in links)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: Colors.white,
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
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: muted,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ikram Ul Haq — Flutter & iOS Developer',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: paper,
      colorScheme: ColorScheme.fromSeed(seedColor: violet, surface: paper),
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: ink, height: 1.5),
      ),
      dividerColor: const Color(0xFFE2E0DA),
    ),
    home: const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();
  final _work = GlobalKey();
  final _about = GlobalKey();
  final _contact = GlobalKey();

  @override
  void dispose() {
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
    body: SelectionArea(
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
                  constraints: const BoxConstraints(maxWidth: 1760),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nav(wide),
                        _hero(wide),
                        const SizedBox(height: 65),
                        _sectionLabel(
                          '01 / SELECTED WORK',
                          'A few things I’ve helped bring to life.',
                          key: _work,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Real products.\nMeaningful contributions.',
                          style: TextStyle(
                            fontSize: wide ? 56 : 38,
                            height: 1.07,
                            letterSpacing: -2.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Web platforms, shared journeys, and everyday healthcare.\nA selection of the products I’ve helped build.',
                          style: TextStyle(
                            color: muted,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 45),
                        _project(
                          0,
                          wide
                              ? ((constraints.maxWidth - padding * 2) * .4)
                                    .clamp(470, 660)
                              : 300,
                        ),
                        const SizedBox(height: 32),
                        CarbeeScreenWall(project: projects.first),
                        const SizedBox(height: 65),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 11,
                                child: Column(
                                  children: [
                                    for (final index in [1, 3, 5])
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 80,
                                        ),
                                        child: _project(
                                          index,
                                          index == 1 ? 520 : 470,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 65),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 145),
                                  child: Column(
                                    children: [
                                      for (final index in [2, 4, 6])
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 80,
                                          ),
                                          child: _project(index, 460),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        else ...[
                          for (var i = 1; i < projects.length; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                left: i.isEven ? 14 : 0,
                                right: i.isOdd ? 14 : 0,
                                bottom: 48,
                              ),
                              child: _project(i, 365),
                            ),
                        ],
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28),
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
                        const SizedBox(height: 110),
                        _aboutSection(wide),
                        const SizedBox(height: 100),
                        _contactSection(wide),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 45,
                            runSpacing: 12,
                            children: [
                              const Text(
                                '© Muhammad Ikram Ul Haq',
                                style: TextStyle(fontSize: 12, color: muted),
                              ),
                              const Text(
                                'Built with Flutter. Made with intention.',
                                style: TextStyle(fontSize: 12, color: muted),
                              ),
                              TextButton(
                                onPressed: () => _scroll.animateTo(
                                  0,
                                  duration:
                                      MediaQuery.disableAnimationsOf(context)
                                      ? Duration.zero
                                      : const Duration(milliseconds: 700),
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
  );

  TextStyle get _eyebrow => const TextStyle(
    fontSize: 10,
    letterSpacing: 2,
    fontWeight: FontWeight.w600,
    color: muted,
  );

  Widget _nav(bool wide) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 28),
    child: Row(
      children: [
        Container(
          width: 37,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'i.',
            style: TextStyle(
              color: paper,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (wide) ...[
          const SizedBox(width: 12),
          const Text(
            'ikram ul haq',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ],
        const Spacer(),
        TextButton(onPressed: () => _go(_work), child: const Text('Work')),
        TextButton(onPressed: () => _go(_about), child: const Text('About')),
        const SizedBox(width: 10),
        if (!wide)
          IconButton(
            onPressed: () => _go(_contact),
            tooltip: 'Let’s talk',
            icon: const Icon(Icons.north_east),
          ),
        if (wide)
          OutlinedButton(
            onPressed: () => _go(_contact),
            style: OutlinedButton.styleFrom(
              foregroundColor: ink,
              side: const BorderSide(color: Color(0xFFCBC9C3)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
            ),
            child: const Text('Let’s talk ↗'),
          ),
      ],
    ),
  );

  Widget _hero(bool wide) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FLUTTER & NATIVE iOS · TEAM LEAD', style: _eyebrow),
        const SizedBox(height: 25),
        Text(
          'Muhammad\nIkram Ul Haq.',
          style: TextStyle(
            fontSize: wide ? 72 : 46,
            height: 1.03,
            letterSpacing: -2.8,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'I build apps.\nAnd help teams build better.',
          style: TextStyle(
            fontSize: wide ? 28 : 23,
            height: 1.3,
            letterSpacing: -.6,
            color: violet,
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 470),
          child: const Text(
            'From a first idea to a production release, I bring hands-on Flutter and iOS engineering, clear architecture, and ownership. I’ve delivered projects independently and led teams through several more.',
            style: TextStyle(fontSize: 16, height: 1.75, color: muted),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 22,
                ),
              ),
              child: const Text('View selected work ↘'),
            ),
            TextButton(
              onPressed: () => _go(_contact),
              child: const Text('Let’s connect ↗'),
            ),
          ],
        ),
        const SizedBox(height: 35),
        const Text(
          'ISLAMABAD, PAKISTAN  /  MOBILE & WEB',
          style: TextStyle(fontSize: 9, letterSpacing: 1.7, color: muted),
        ),
      ],
    );
    final portrait = SizedBox(
      height: wide ? 540 : 420,
      child: Stack(
        children: [
          Positioned.fill(
            left: 20,
            top: 0,
            right: 0,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE4E0D8),
                borderRadius: BorderRadius.circular(26),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/ikram.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                semanticLabel: 'Muhammad Ikram Ul Haq',
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                color: ink,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Text(
                    '15+',
                    style: TextStyle(
                      color: paper,
                      fontSize: 37,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      'Apps built & contributed to\nAcross products, platforms, and teams.',
                      style: TextStyle(color: paper, fontSize: 11, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: wide ? 58 : 25, bottom: 25),
      child: Column(
        children: [
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 65),
                Expanded(flex: 5, child: portrait),
              ],
            )
          else ...[
            intro,
            const SizedBox(height: 35),
            portrait,
          ],
          const SizedBox(height: 58),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              spacing: wide ? 44 : 24,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                for (final label in [
                  'Flutter',
                  'Dart',
                  'Native iOS',
                  'BLoC / Cubit',
                  'Firebase',
                  'CI/CD',
                ])
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const Divider(),
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
        Text(trailing, style: const TextStyle(fontSize: 11, color: muted)),
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
                                style: const TextStyle(
                                  color: muted,
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
                      style: TextStyle(fontSize: 11, color: muted),
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
            fontSize: wide ? 45 : 35,
            letterSpacing: -1.8,
            height: 1.12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'I’m Muhammad Ikram Ul Haq, a Flutter developer with native iOS experience. I’ve independently completed several projects from start to finish and led teams to deliver several more. Across startups, product teams, and service companies, I bring hands-on engineering and the leadership to help teams ship with confidence.',
          style: TextStyle(fontSize: 16, height: 1.8, color: muted),
        ),
        const SizedBox(height: 18),
        const Text(
          'My focus is clean architecture, intuitive interfaces, and the engineering behind them: reliable integrations, maintainable code, and thoughtful release workflows.',
          style: TextStyle(fontSize: 16, height: 1.8, color: muted),
        ),
        const SizedBox(height: 28),
        const Text(
          'BS Computer Science · Federal Urdu University\n2016–2020 · CGPA 3.59',
          style: TextStyle(fontSize: 12, height: 1.8, color: muted),
        ),
      ],
    );
    final experience = Column(
      children: [
        for (final role in [
          (
            'Techtronix',
            'Team Lead Flutter Developer',
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
                        style: const TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.1,
                          color: muted,
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
                        style: const TextStyle(fontSize: 12, color: muted),
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

  Widget _contactSection(bool wide) => Container(
    key: _contact,
    width: double.infinity,
    padding: EdgeInsets.all(wide ? 55 : 27),
    decoration: BoxDecoration(
      color: ink,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '03 / WHAT’S NEXT?',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            color: Color(0xFFB7B3C0),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Have something\ngood in mind?',
          style: TextStyle(
            fontSize: wide ? 65 : 39,
            height: 1.05,
            letterSpacing: -2,
            fontWeight: FontWeight.w500,
            color: paper,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Let’s turn it into something people love to use.',
          style: TextStyle(color: Color(0xFFB7B3C0), height: 1.6),
        ),
        const SizedBox(height: 25),
        const SelectableText(
          'emikramulhaq@gmail.com',
          style: TextStyle(color: Color(0xFFD0BDFF), fontSize: 18),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () =>
                  _copy(context, 'emikramulhaq@gmail.com', 'Email copied'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD0BDFF),
                foregroundColor: ink,
              ),
              icon: const Icon(Icons.copy, size: 15),
              label: const Text('Copy email'),
            ),
            TextButton(
              onPressed: () => _social(
                'LinkedIn',
                'https://www.linkedin.com/in/em-ikram-a718a9145/',
              ),
              child: const Text('LinkedIn ↗', style: TextStyle(color: paper)),
            ),
            TextButton(
              onPressed: () => _social('GitHub', 'https://github.com/EMIkram'),
              child: const Text('GitHub ↗', style: TextStyle(color: paper)),
            ),
          ],
        ),
      ],
    ),
  );

  void _social(String name, String url) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(name),
      content: SelectableText(url),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        FilledButton(
          onPressed: () => _copy(context, url, '$name link copied'),
          child: const Text('Copy link'),
        ),
      ],
    ),
  );
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
                color: widget.project.color,
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
                              scale: _hovered && !_reduceMotion ? 1.04 : 1,
                              duration: _reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                              child: Transform.translate(
                                offset: Offset(0, _shift),
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
                      fontSize: 25,
                      letterSpacing: -.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '0${widget.index + 1}',
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.project.summary,
              style: const TextStyle(fontSize: 14, color: muted),
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.category,
              style: const TextStyle(
                fontSize: 9,
                letterSpacing: 1.6,
                color: muted,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
