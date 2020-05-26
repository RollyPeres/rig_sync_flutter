import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rig_sync_flutter/utilities/stream/handle_stream.dart';
import 'package:rig_sync_flutter/widgets/basic.dart';
import 'package:rig_sync_flutter/widgets/lineChart.dart';

class ElementDashboardScreen extends StatelessWidget {
  static const routeName = '/elementDashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RigSync - Detail Page'),
      ),
      body: Center(
        // equivalent of Provider.of<String>(context);
        child: Consumer<String>(
          builder: (context, value, child) {
            if (value == null) {
              return const Spinner();
            }
            if (value == '') {
              return const ErrorText();
            }
            // this can be replaced with extension method on String; it would end up in `value.dataKeys()`. You'd need at least dart sdk 2.6.0 (in pubspec.yaml)
            var keys = HandleStream(value).dataKeys();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    "This might be a page where you can focus on one input at a time. Maybe you click on a particular graph on the dashboard page and it brings you to a page with only that graph."),
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
