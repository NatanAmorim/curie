import 'package:curie/src/controllers/settings_controller.dart';
import 'package:curie/src/routes.dart';
import 'package:curie/src/views/error/error_screen.dart';
import 'package:curie/src/views/navigation_test/navigation_test_screen.dart';
import 'package:curie/src/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;
  late Routes routes;

  @override
  Widget build(BuildContext context) {
    routes = Routes(settingsController: settingsController);

    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: settingsController.locale,
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('pt', ''), // Portuguese, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          initialRoute: NavigationTestScreen.routeName,
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          // TODO: put this logic in a separated file called router.dart
          onGenerateRoute: routes.onGenerateRoute,
        );
      },
    );
  }
}
