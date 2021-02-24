import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/localization_store.dart';

import 'package:guard_class/app/core/stores/theme_store.dart';
import 'package:guard_class/app/core/theme/theme_data_configuration.dart';

ThemeData lightTheme = ThemeDataConfiguration.instance.getLightTheme();
ThemeData darkTheme = ThemeDataConfiguration.instance.getDarkTheme();

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final _themeStore = Modular.get<ThemeStore>();
  final _localizationStore = Modular.get<LocalizationStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    changeTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    changeTheme();
  }

  changeTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    _themeStore.setBrightness(brightness);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        navigatorKey: Modular.navigatorKey,
        title: 'Cold Is Not Frozen',
        theme: _themeStore.brightness == Brightness.dark ? ThemeDataConfiguration.instance.getDarkTheme() : ThemeDataConfiguration.instance.getLightTheme(),
        initialRoute: Modular.initialRoute,
        builder: asuka.builder,
        onGenerateRoute: Modular.generateRoute,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          _localizationStore.setDeviceLocale(deviceLocale);
          return deviceLocale;
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('pt' 'BR'),
          Locale('en' 'US'),
        ],
      ),
    );
  }
}
