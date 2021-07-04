import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appProviders({required Widget child}) {
  return MultiProvider(providers: [
    ChangeNotifierProvider<SocketService>(create: (_) => SocketService()),
  ], child: child);
}
