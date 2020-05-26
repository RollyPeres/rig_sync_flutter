import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rig_sync_flutter/utilities/stream/handle_stream.dart';
import 'package:rig_sync_flutter/widgets/basic.dart';
import 'package:rig_sync_flutter/widgets/lineChart.dart';
import './element_dashboard_screen.dart';

class MainDashboardScreen extends StatelessWidget {
  static const routeName = '/mainDashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RigSync'),
        actions: [
          RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ElementDashboardScreen.routeName);
              },
              child: Text("Go to Second Page"))
        ],
      ),
      body: Center(
        child: Consumer<String>(
          builder: (context, value, child) {
            if (value == null) {
              return const Spinner();
            }
            if (value == '') {
              return const ErrorText();
            }
            var keys = HandleStream(value).dataKeys();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (ctx, i) =>
                        DataLine(incomingData: value, targetElement: keys[i]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
