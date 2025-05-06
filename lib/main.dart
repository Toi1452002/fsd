import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/app_router/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('vi', '')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android:CupertinoPageTransitionsBuilder()
          }
        ),
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
          ),
        ),
        drawerTheme: DrawerThemeData(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.blue.shade700,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20
          )
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          iconSize: 20,
          position:PopupMenuPosition.under,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3)
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3)
          )
        ),
        cardTheme: CardTheme(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3)
          ),
        )
      ),
    );
  }
}
