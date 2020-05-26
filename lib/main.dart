import 'package:flutter/material.dart';
import 'package:rig_sync_flutter/repositories/data_repository.dart';
// Screens
import 'package:rig_sync_flutter/screens/main_dashboard_screen.dart';
import 'package:rig_sync_flutter/screens/element_dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // instantiate this repo once and get it through context if needed
        Provider<DataRepository>(create: (_) => DataRepository()),
        StreamProvider<String>(
          create: (context) =>
              Provider.of<DataRepository>(context, listen: false).dataStream(),
          catchError: (_, error) {
            print("There's been an error: $error");
            return '';
          },
        )
      ],
      child: const RigSync(),
    ),
  );
}

class RigSync extends StatelessWidget {
  const RigSync({Key key}) : super(key: key);
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rigSync Demo',
      theme: ThemeData.dark(),
      home: MainDashboardScreen(),
      routes: {
        MainDashboardScreen.routeName: (ctx) => MainDashboardScreen(),
        ElementDashboardScreen.routeName: (ctx) => ElementDashboardScreen(),
      },
    );
  }
}
