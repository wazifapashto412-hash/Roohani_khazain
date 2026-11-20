import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_state.dart';
import 'repository.dart';
import 'screens/home_screen.dart';

const emerald = Color(0xFF0B5D3B);
const gold = Color(0xFFC9A227);
const cream = Color(0xFFFAF5E6);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = Repository();
  await repo.load();
  runApp(App(AppState(repo)));
}

class App extends StatelessWidget {
  final AppState state;
  const App(this.state, {super.key});

  ThemeData _theme(Brightness b) {
    final scheme = ColorScheme.fromSeed(seedColor: emerald, secondary: gold, brightness: b);
    return ThemeData(
      colorScheme: scheme, useMaterial3: true,
      scaffoldBackgroundColor: b == Brightness.light ? cream : const Color(0xFF0E1A14),
      appBarTheme: AppBarTheme(backgroundColor: emerald, foregroundColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: state,
        builder: (_, __) => MaterialApp(
          title: 'روحانی خزائن',
          debugShowCheckedModeBanner: false,
          locale: const Locale('ur'),
          supportedLocales: const [Locale('ur'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: _theme(Brightness.light),
          darkTheme: _theme(Brightness.dark),
          themeMode: state.dark ? ThemeMode.dark : ThemeMode.light,
          home: Directionality(textDirection: TextDirection.rtl, child: HomeScreen(state)),
        ),
      );
}
