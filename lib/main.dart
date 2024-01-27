import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yandex_map/ui/screen/clubs_ads_add.dart';
import 'package:yandex_map/ui/screen/sign_up_page.dart';
import 'bloc/auth_register_bloc/auth_register_bloc.dart';
import 'generated/l10n.dart';
import 'ui/screen/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthRegisterBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('ru')],
        home: SignInPage(),
      ),
    );
  }
}

