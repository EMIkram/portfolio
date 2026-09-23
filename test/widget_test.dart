import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/main.dart';
import 'package:portfolio_flutter/portfolio_data.dart';
import 'package:portfolio_flutter/screenshot_gallery.dart';

void main() {
  testWidgets('Effects icon responds to available width', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.physicalSize = const Size(420, 800);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byTooltip('Turn off cursor effects'), findsOneWidget);
    tester.view.physicalSize = const Size(320, 800);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Turn off cursor effects'), findsNothing);
    for (final label in ['Email', 'GitHub', 'LinkedIn', 'Download resume']) {
      expect(find.byTooltip(label), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Phone header stays in one row at 320 pixels', (tester) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    final resumeY = tester.getCenter(find.byTooltip('Download resume')).dy;
    for (final label in [
      'GitHub',
      'LinkedIn',
      'Email',
      'Switch to dark mode',
    ]) {
      expect(tester.getCenter(find.byTooltip(label)).dy, closeTo(resumeY, 1));
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Header compacts while scrolling and expands at the top', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    final expandedHeight = tester
        .getSize(find.byKey(const ValueKey('expanded-header')))
        .height;
    final scroll = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView).first)
        .controller!;
    final shell = find.byKey(const ValueKey('header-shell'));
    final expandedWidth = tester.getSize(shell).width;
    scroll.jumpTo(300);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final transitionWidth = tester.getSize(shell).width;
    await tester.pumpAndSettle();
    expect(transitionWidth, lessThan(expandedWidth));
    expect(transitionWidth, greaterThan(tester.getSize(shell).width));
    expect(
      tester.getSize(find.byKey(const ValueKey('compact-header'))).height,
      lessThan(expandedHeight),
    );
    for (final label in ['GitHub', 'Email', 'Download resume']) {
      expect(find.byTooltip(label), findsOneWidget);
    }
    scroll.jumpTo(0);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('expanded-header')), findsOneWidget);
    expect(find.text('Download resume'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Failed screenshot offers retry instead of a blank preview', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ScreenshotImage('missing-screenshot.png')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Retry screenshot'), findsOneWidget);
    await tester.tap(find.text('Retry screenshot'));
    await tester.pumpAndSettle();
    expect(find.text('Retry screenshot'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Header contacts and light/dark switch remain available', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Download resume'), findsOneWidget);
    expect(resumeUrl, isNotEmpty);
    expect(find.byTooltip('Turn off cursor effects'), findsNothing);
    for (final label in ['Email', 'GitHub', 'LinkedIn']) {
      expect(find.byTooltip(label), findsOneWidget);
    }
    await tester.tap(find.byTooltip('Switch to dark mode'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(PortfolioPage))).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byTooltip('Switch to light mode'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(PortfolioPage))).brightness,
      Brightness.light,
    );
  });

  testWidgets('Carbee collection expands and collapses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: CarbeeScreenWall(
              project: projects.firstWhere(
                (project) => project.name == 'Carbee',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(BrowserFrame), findsNothing);
    await tester.tap(find.text('A closer look at Carbee'));
    await tester.pumpAndSettle();
    expect(find.byType(BrowserFrame), findsWidgets);
    await tester.tap(find.text('A closer look at Carbee'));
    await tester.pumpAndSettle();
    expect(find.byType(BrowserFrame), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('My Treats offers only iOS and restaurant website', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showProjectLinks(context, 'My Treats'),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Google Play'), findsNothing);
    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('Restaurant website'), findsOneWidget);
    expect(
      projectLinks['My Treats']!.first.$2,
      'https://apps.apple.com/gb/app/my-treats/id1553674065',
    );
  });
  testWidgets('Projects with both stores offer a platform chooser', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showProjectLinks(context, 'Carbee'),
              child: const Text('Open Carbee'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open Carbee'));
    await tester.pumpAndSettle();
    expect(find.text('Explore Carbee'), findsOneWidget);
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('Website'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Explore Carbee'), findsNothing);
  });
  for (final width in [390.0, 1440.0]) {
    testWidgets('Portfolio navigation and project details at $width px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Muhammad\nIkram Ul Haq.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      for (final name in ['Carbee', 'Dr.iQ']) {
        final copy = tester.getRect(find.byKey(ValueKey('project-copy-$name')));
        final images = tester.getRect(
          find.byKey(ValueKey('project-images-$name')),
        );
        if (width >= 800) {
          expect(
            name == 'Carbee'
                ? copy.right < images.left
                : images.right < copy.left,
            isTrue,
          );
        } else {
          expect(copy.bottom, lessThan(images.top));
        }
      }
      await Scrollable.ensureVisible(
        tester.element(find.text('View selected work ↘')),
        alignment: .5,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('View selected work ↘'));
      await tester.pumpAndSettle();
      final carbee = find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            w.properties.label == 'View Carbee project details',
      );
      await Scrollable.ensureVisible(tester.element(carbee), alignment: .5);
      await tester.pumpAndSettle();
      await tester.tap(carbee);
      await tester.pumpAndSettle();
      final dialog = find.byType(Dialog);
      expect(
        find.descendant(of: dialog, matching: find.text('My contribution')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: dialog,
          matching: find.textContaining(
            'I joined Carbee as one of its founding engineers',
            findRichText: true,
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('40,000')),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Close project'));
      await tester.pumpAndSettle();
      final entimocare = find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            w.properties.label == 'View Entimocare project details',
      );
      await Scrollable.ensureVisible(tester.element(entimocare), alignment: .5);
      await tester.pumpAndSettle();
      await tester.tap(entimocare);
      await tester.pumpAndSettle();
      expect(
        find.descendant(of: find.byType(Dialog), matching: find.text('4 apps')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Close project'));
      await tester.pumpAndSettle();
      final scrollable = find.byType(Scrollable).first;
      for (var i = 0; i < 15; i++) {
        await tester.drag(scrollable, const Offset(0, -600));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(find.byTooltip('Email'), findsOneWidget);
      expect(tester.getTopLeft(find.byTooltip('Email')).dy, lessThan(220));
    });
  }
  testWidgets('Reduced motion keeps project previews visible', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(800, 900), disableAnimations: true),
          child: PortfolioPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final tile = find.byType(ProjectTile).first;
    final opacity = tester.widget<Opacity>(
      find.descendant(of: tile, matching: find.byType(Opacity)).first,
    );
    expect(opacity.opacity, 1);
  });
  testWidgets('Screenshot tabs and full-screen zoom use the selected screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ScreenshotGallery(
              project: projects.firstWhere(
                (project) => project.name == 'Carbee',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(ChoiceChip, 'Foundations · Design system'),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<BrowserFrame>(find.byType(BrowserFrame)).screen.$2,
      'assets/images/carbee-foundations.png',
    );
    await tester.ensureVisible(find.text('Expand screenshot'));
    await tester.tap(find.text('Expand screenshot'));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);
    await tester.tap(find.byTooltip('Close screenshot'));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
