import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/data/remote/dio_helper_news.dart';
import 'package:video2/data/remote/dio_helper_search.dart';
import 'package:video2/presentation/screens/login_screen.dart';
import 'package:video2/presentation/screens/splash_screen.dart';
import 'package:video2/presentation/style/themes.dart';

import 'bussiness_logic/MyBlocObserver.dart';
import 'data/local/cache_helper.dart';
import 'data/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  DioHelperNews.init();
  DioHelperSearch.init();
  statusBarColor();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      LocalizedApp(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GlobalCubit(),
              ),
              BlocProvider(
                create: (context) => SearchCubit()..getNewsData(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,

              home: const SplashScreen(),
              localizationsDelegates:
                  translator.delegates, // Android + iOS Delegates
              locale: translator.locale, // Active locale
              supportedLocales: translator.locals(), // Locals list
            ),
          );
        },
      ),
    );
  }
}
