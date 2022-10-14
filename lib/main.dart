import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ldp/FileOutput.dart';
import 'package:ldp/service/e_dealer/sef.dart';
import 'package:ldp/service/e_dealer/sif.dart';
import 'package:ldp/service/e_dealer/wc.dart';
import 'package:ldp/service/masters/actual_per_ro_targets.dart';
import 'package:ldp/service/masters/actual_revenue_targets.dart';
import 'package:ldp/service/masters/aspirational_per_ro_targets.dart';
import 'package:ldp/service/masters/aspirational_revenue_targets.dart';
import 'package:ldp/service/masters/location_mapping.dart';
import 'package:ldp/service/masters/models_mapping.dart';
import 'package:ldp/service/uploads.dart';
import 'package:ldp/service/view_file_upload_history.dart';

import 'change_password.dart';
import 'login.dart';
import 'dashboard.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:logger/logger.dart';

import 'globals.dart' as globals;

import 'package:url_strategy/url_strategy.dart';

import 'dart:html' as html;

// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_authenticator/amplify_authenticator.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';

// import 'amplifyconfiguration.dart';

bool is_Login = false;

bool is_Sentry_on = false;
// bool is_Sentry_on = true;

// var logger = Logger(
//   printer: PrettyPrinter(),
// );

// var loggerNoStack = Logger(
//   printer: PrettyPrinter(methodCount: 0),
// );

Future<void> main() async {
  globals.loggerfile.d("Logger Started");

  setPathUrlStrategy();

  is_Sentry_on
      ? await SentryFlutter.init(
          (options) {
            options.dsn =
                'https://5d2382ba981f4c7a98f4d4996d872b26@o1016722.ingest.sentry.io/6691276';

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0;
          },
          // Init your App.
          appRunner: () => runApp(const MyApp()),
        )
      : runApp(const MyApp());

  // log();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LDP',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/dashboard': (context) => const dashboard(),
        '/uploads': (context) => const uploads(),
        '/view_file_upload_history': (context) =>
            const view_file_upload_history(),
        '/sef': (context) => const sef(),
        '/sif': (context) => const sif(),
        '/wc': (context) => const wc(),

        '/actual_per_ro_targets': (context) => const actual_per_ro_targets(),
        '/actual_revenue_targets': (context) => const actual_revenue_targets(),
        '/aspirational_per_ro_targets': (context) =>
            const aspirational_per_ro_targets(),
        '/aspirational_revenue_targets': (context) =>
            const aspirational_revenue_targets(),
        '/location_mapping': (context) => const location_mapping(),
        '/models_mapping': (context) => const models_mapping(),

        '/change_password': (context) => const change_password(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.blue,
      ),

      home: is_Login
          ? dashboard()
          : login(), // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // @override
  // void initState() {
  //   super.initState();

  //   var logger = Logger(
  //     printer: PrettyPrinter(),
  //   );
  // }

  // void _configureAmplify() async {
  //   try {
  //     await Amplify.addPlugin(AmplifyAuthCognito());
  //     await Amplify.configure(amplifyconfig);
  //     print('Successfully configured');
  //   } on Exception catch (e) {
  //     print('Error configuring Amplify: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// rm -rf /opt/homebrew/etc/nginx /opt/homebrew/etc/nginx/fastcgi.conf
// /opt/homebrew/etc/nginx/fastcgi.conf.default /opt/homebrew/etc/nginx/fastcgi_params /opt/homebrew/etc/nginx/fastcgi_params.default /opt/homebrew/etc/nginx/koi-utf /opt/homebrew/etc/nginx/koi-win /opt/homebrew/etc/nginx/mime.types /opt/homebrew/etc/nginx/mime.types.default /opt/homebrew/etc/nginx/nginx.conf /opt/homebrew/etc/nginx/nginx.conf.default /opt/homebrew/etc/nginx/scgi_params /opt/homebrew/etc/nginx/scgi_params.default /opt/homebrew/etc/nginx/uwsgi_params /opt/homebrew/etc/nginx/uwsgi_params.default /opt/homebrew/etc/nginx/win-utf
















