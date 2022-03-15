import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Testing the Favorites page', () {
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Favorites page should be empty when no favorites',
        (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      expect(find.text('Item'), findsNothing);
    });

    testWidgets('Favorites page should have favorites when added',
        (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      // Find all the X icons
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      expect(find.text('Item 0'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          equals(totalItems - 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
