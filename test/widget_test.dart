import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/main.dart';
import 'package:portfolio_flutter/portfolio_data.dart';
import 'package:portfolio_flutter/screenshot_gallery.dart';

void main() {
  testWidgets('Carbee collection expands and collapses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: CarbeeScreenWall(project: projects.first),
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
      await tester.ensureVisible(find.text('View selected work ↘'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View selected work ↘'));
      await tester.pumpAndSettle();
      final carbee = find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            w.properties.label == 'View Carbee project details',
      );
      await tester.ensureVisible(carbee);
      await tester.pumpAndSettle();
      await tester.tap(carbee);
      await tester.pumpAndSettle();
      expect(find.text('My contribution'), findsOneWidget);
      expect(
        find.textContaining('Primary owner of the Carbee'),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Close project'));
      await tester.pumpAndSettle();
      final scrollable = find.byType(Scrollable).first;
      for (var i = 0; i < 15; i++) {
        await tester.drag(scrollable, const Offset(0, -600));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(find.text('emikramulhaq@gmail.com'), findsOneWidget);
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
            child: ScreenshotGallery(project: projects.first),
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
