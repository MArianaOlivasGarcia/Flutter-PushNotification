

import 'package:flutter/material.dart';
import 'package:push/pages/home.page.dart';
import 'package:push/pages/mensaje.page.dart';
import 'package:push/providers/push.provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen( (argumento) {
    /*   
    print('Argumento desde main: $argumento');
    Navigator.pushNamed(context, 'mensaje');
    */
    navigatorKey.currentState.pushNamed('mensaje', arguments: argumento );
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home'   : (_) => HomePage(),
        'mensaje': (_) => MensajePage(),
      }
    );
  }
}