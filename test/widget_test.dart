import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/main.dart';
import 'package:portfolio_flutter/portfolio_data.dart';
import 'package:portfolio_flutter/screenshot_gallery.dart';

void main() {
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
      expect(
        find.text('Great ideas.\nBeautifully\nengineered.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Explore my work     ↘'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore my work     ↘'));
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
