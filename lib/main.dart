import 'package:band_names/src/pages/home_page.dart';
import 'package:band_names/src/pages/status_page.dart';
import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocketService>(create: (_) => SocketService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: StatusPage().pageName,
        routes: {
          HomePage().pageName: (_) => HomePage(),
          StatusPage().pageName: (_) => StatusPage(),
        },
      ),
    );
  }
}
