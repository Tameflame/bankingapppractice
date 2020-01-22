import 'package:banking_app/api/auth/auth.dart';
// import 'package:banking_app/api/transactions/transaction_api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banking_app/pages/pages_barrel.dart';
import 'package:bloc/bloc.dart';
import 'package:banking_app/style.dart';
import 'bloc/bloc_delegate.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = MyBlocDelegate();
  return runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(authApi: AuthApi())..add(AppStarted()),
      ),
      BlocProvider<LoginFlowBloc>(
        create: (BuildContext context) => LoginFlowBloc(),
      ),
      BlocProvider<TransactionBloc>(
        create: (BuildContext context) => TransactionBloc(
          // TransactionStreamer()
          )..add(GetTransactions()),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Probably going to  need multibloc provider
      // The builder will then return whichever starting page is needed
      // Or Actually maybe use BlocListener, as it seems  like
      // the new way to handle navigation with routes
      // go see the guy's reply to me
      theme: myTheme,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          }
          if (state is Authenticated) {
            return HomePage();
          }
          if (state is NotAuthenticated) {
            return LoginSignupPage();
          } else
            throw Exception("Something went wrong here, state was $state");
        },
      ),
      // home: LoginSignupPage(),
      routes: <String, WidgetBuilder>{
        '/LoginSignupPage': (context) => LoginSignupPage(),
        '/LoginFormPage': (context) => LoginFormPage(),
        '/SignupPage1': (context) => SignupPage1(),
        '/SignupPage2': (context) => SignupPage2(),
        '/HomePage': (context) => HomePage(),
      },
    );
  }
}

//// this main is supposed to force portrait mode on mobile, but
//// it won't work on chrome. I'm guessing its because of the
//// WidgetsFlutterBinding.ensureInitializse() method
//// Or alternatively it might be because its a Future<void> return?
//// If it's the latter, then maybe try converting  into a regular
//// void return, and change the await into Future<Void>blah.then(() {runApp})
//// if you get what im saying!

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   BlocSupervisor.delegate = MyBlocDelegate();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//     ]);
//   return runApp(BlocProvider(
//     create: (BuildContext context) => new PageManagerBloc()
//     ..add(GotoSplashPage()),
//     child: MyApp(),
//   ));
// }
