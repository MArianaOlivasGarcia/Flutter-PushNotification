

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajesStreamController.stream;


  static Future<dynamic> onBackgroundMessage( Map<String, dynamic> mensaje) async {

    if( mensaje.containsKey('data') ){
      final dynamic data = mensaje['data'];
    }

    if( mensaje.containsKey('notification') ){
      final dynamic notification = mensaje['notification'];
    }
  

  }



  initNotifications() async{

    // Token que identifica a un dispositivo de manera unica
    await _firebaseMessaging.requestNotificationPermissions();

    final token = await _firebaseMessaging.getToken();
    print('== TOKEN == : $token');


    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );  

  }




  Future<dynamic> onMessage( Map<String, dynamic> mensaje) async {

    print('=====  onMessage  ======');
    print('mensaje: $mensaje');

    final argumento = mensaje['data']['comida'] ?? 'no-data';

    print('argumento: $argumento');

    _mensajesStreamController.sink.add( argumento );

  }


  Future<dynamic> onLaunch( Map<String, dynamic> mensaje) async {

    print('=====  onLaunch  ======');
    print('mensaje: $mensaje');

    final argumento = mensaje['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add( argumento );


  }



  Future<dynamic> onResume( Map<String, dynamic> mensaje) async {

    print('=====  onResume  ======');
    print('mensaje: $mensaje');

    final argumento = mensaje['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add( argumento );


  }


  dispose() {
    _mensajesStreamController?.close();
  }

}