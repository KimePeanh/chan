import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_bloc.dart';
import 'package:lady_skin/src/features/favourite/bloc/favourite_bloc.dart';
import 'package:lady_skin/src/features/language/bloc/language_event.dart';
import 'package:lady_skin/src/features/language/bloc/language_state.dart';
import 'package:lady_skin/src/features/my_order/bloc/my_order_bloc.dart';
import 'package:lady_skin/src/features/my_order/repositories/my_order_respository.dart';
import 'package:lady_skin/src/features/notification/bloc/notification_bloc.dart';
import 'src/config/routes/route_generator.dart';
import 'src/config/themes/app_theme.dart';
import 'src/features/authentication/bloc/index.dart';
import 'src/features/cart/bloc/cart_bloc.dart';
import 'src/features/category/bloc/index.dart';
import 'src/features/landing/screen/landing_page.dart';
import 'src/features/language/bloc/language_bloc.dart';
import 'src/shared/bloc/theme/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/utils/helper/helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  // await FlutterNotificationChannel.registerNotificationChannel(
  //   description: 'Your channel description',
  //   id: 'default',
  //   importance: NotificationImportance.IMPORTANCE_HIGH,
  //   name: 'default',
  //   visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  //   allowBubbles: true,
  //   enableVibration: true,
  //   enableSound: true,
  //   showBadge: true,
  // );
  // await PushNotificationsService().init();
  await dotenv.load(fileName: 'assets/.env');
  runApp(AppInitializer());
}

class AppInitializer extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Helper>(create: (BuildContext context) => Helper())
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AccountBloc>(
                create: (BuildContext context) => AccountBloc()),
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) =>
                  AuthenticationBloc()..add(CheckingAuthenticationStarted()),
            ),
            BlocProvider<CategoryBloc>(
              create: (BuildContext context) =>
                  CategoryBloc()..add(FetchCategory()),
            ),
            BlocProvider<CartBloc>(
              create: (BuildContext context) => CartBloc(),
            ),
            BlocProvider<ThemeBloc>(
              create: (BuildContext context) =>
                  ThemeBloc()..add(ThemeChange(theme: AppTheme.Light)),
            ),
            BlocProvider<LanguageBloc>(
              create: (BuildContext context) =>
                  LanguageBloc()..add(LanguageLoadStarted()),
            ),
            BlocProvider<FavouriteBloc>(
                create: (BuildContext context) => FavouriteBloc()),
            BlocProvider<MyOrderBloc>(
                create: (BuildContext context) =>
                    MyOrderBloc(orderRepository: OrderByPendingRepo())),
            BlocProvider<NotificationBloc>(
                create: (BuildContext context) => NotificationBloc()),
            BlocProvider<CheckoutBloc>(
                create: (BuildContext context) => CheckoutBloc()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, theme) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, languageState) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  locale: languageState.locale,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    AppLocalizations.delegate,
                  ],
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('km', 'KH'),
                  ],
                  debugShowCheckedModeBanner: false,
                  title: 'CHAMROEUNPHAL',
                  home: LandingPage(),
                  theme: theme,
                );
              });
            },
          )),
    );
  }
}
