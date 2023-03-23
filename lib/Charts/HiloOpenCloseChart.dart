import 'package:demo_project/candleData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HiloOpenCloseChart extends StatefulWidget {
  const HiloOpenCloseChart({super.key});

  @override
  State<HiloOpenCloseChart> createState() => _HiloOpenCloseChartState();
}

class _HiloOpenCloseChartState extends State<HiloOpenCloseChart> {
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  List<Map> staticData = CandleData.data;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("staticData :${date}");
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SfCartesianChart(
        title: ChartTitle(text: 'AUD/USD'),
        zoomPanBehavior: _zoomPanBehavior,
        trackballBehavior: _trackballBehavior,
        series: <HiloOpenCloseSeries>[
          HiloOpenCloseSeries<Map, DateTime>(
              dataSource: staticData,
              xValueMapper: (staticData, _) => DateFormat('dd/MM/yyyy hh:mm')
                  .parse(staticData['CandleDate']),
              lowValueMapper: (staticData, _) => staticData['LowPrice'],
              highValueMapper: (staticData, _) => staticData['HighPrice'],
              openValueMapper: (staticData, _) => staticData['OpenPrice'],
              closeValueMapper: (staticData, _) => staticData['ClosePrice'])
        ],
        primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm()),
      ),
    )));
  }
}
