import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Helps check for internet connection
class InternetConnectivity {
  /// Helps check for internet connection
  InternetConnectivity._();

  static final _instance = InternetConnectivity._();

  /// get single instance of internet connection
  static InternetConnectivity get instance => _instance;

  final _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController.broadcast();

  /// returns a stream of internet connection states
  Stream<bool> get internetStream => _controller.stream;

  /// initialise the stream and subscribe to it to listen for changes
  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkOnlineStatus(result);

    // listen for changes/movements in the stream
    _connectivity.onConnectivityChanged.listen((event) {
      _checkOnlineStatus(event);
    });
  }

  /// check if connected to the internet
  void _checkOnlineStatus(ConnectivityResult result) async {
    bool isOnline = false;
    isOnline = await InternetConnectionChecker().hasConnection;
    debugPrint('InternetConnectivity: is user still connected to the internet = $isOnline');

    // send it to the stream
    _controller.sink.add(isOnline);
    
  }

  /// unsubscribe and close active listener to internet stream
  void closeConnectionStream() => _controller.close();
}
