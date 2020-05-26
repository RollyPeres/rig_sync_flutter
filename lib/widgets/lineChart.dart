import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rig_sync_flutter/utilities/stream/handle_stream.dart';

class DataLine extends StatefulWidget {
  DataLine({@required this.incomingData, @required this.targetElement});

  final String incomingData;
  final String targetElement;

  @override
  _DataLineState createState() => _DataLineState();
}

// -------- State Class
class _DataLineState extends State<DataLine> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  String currentData;
  List<FlSpot> dataSet = [];
  double lastDataPoint;
  int dataSetMaxLength = 10;

  @override
  void initState() {
    super.initState();
  }

  void generateDataSet() {
    setState(() {
      var curData =
          HandleStream(widget.incomingData).getKeyData(widget.targetElement);

      dataSet.insert(0, FlSpot(curData[0], curData[1]));
      lastDataPoint = curData[1];

      if (dataSet.length >= dataSetMaxLength + 1) {
        dataSet.removeAt(dataSetMaxLength);
      }
    });
  }

  // MAIN BUILD METHOD
  @override
  Widget build(BuildContext context) {
    generateDataSet();

    return Container(
      padding: EdgeInsets.all(15),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LineChart(
              mainData(),
            ),
            Card(
              margin: EdgeInsets.only(left: 55, right: 0, top: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Load: ${lastDataPoint.toString()} T'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      axisTitleData: FlAxisTitleData(
        leftTitle: AxisTitle(
          showTitle: true,
          titleText: 'Load',
          textStyle: TextStyle(
            fontSize: 15,
            color: Color(0xff68737d),
          ),
          margin: 10,
        ),
        topTitle: AxisTitle(
          showTitle: true,
          titleText: widget.targetElement,
          textStyle: TextStyle(
            fontSize: 20,
            color: Color(0xff68737d),
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),

          reservedSize: 28,
          // margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minY: 0,
      maxY: 15,
      lineBarsData: [
        LineChartBarData(
          // THIS IS THE DATA
          spots: dataSet,
          isCurved: true,
          curveSmoothness: 0.3,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
