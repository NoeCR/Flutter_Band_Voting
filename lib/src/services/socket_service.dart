import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService() {
    this._initConfig();
  }

  ServerStatus get serverStatus => _serverStatus;

  void _initConfig() {
    // Socket socket = io(
    //   'http://192.168.1.42:3001/',
    //   OptionBuilder().setTransports(['websocket']).build(),
    // );
    IO.Socket socket = IO.io('http://192.168.1.42:3001/', {
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.connect();

    socket.on('connect', (_) {
      print('Connected');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.on('disconnect', (_) {
      print('Disconnected');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
