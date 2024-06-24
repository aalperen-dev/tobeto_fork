import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/blocs/language/language_cubit.dart';
import 'package:tobeto/src/blocs/theme/theme_bloc.dart';
import 'package:tobeto/src/common/router/app_route_generator.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainApp extends StatefulWidget {
  final ThemeData themeData;
  const MainApp({
    super.key,
    required this.themeData,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int? initScreen;

  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.authStateChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null
            ? AppRouteNames.platformScreenRoute
            : AppRouteNames.homeRoute,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ThemeBloc(ThemeState(themeData: widget.themeData)),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: UserRepository(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: state.themeData,
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigatorKey,
                onGenerateRoute: AppRouter().generateRoute,
                // initialRoute: initScreen == 0 || initScreen == null
                //     ? AppRouteNames.onboardingRoute
                //     : AppRouteNames.platformScreenRoute,
                initialRoute: FirebaseAuth.instance.currentUser == null
                    ? AppRouteNames.homeRoute
                    : AppRouteNames.platformScreenRoute,
              );
            },
          );
        },
      ),
    );
  }
}
