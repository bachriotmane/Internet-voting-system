import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CartPage> {
// Data for the pie chart
  Map<String, double> dataMap = {
    "Programme 1": 60,
    "Programme 2": 30,
    "Programme 3": 10,
  };

// Colors for each segment
// of the pie chart
  List<Color> colorList = [
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFE9539)
  ];

// List of gradients for the
// background of the pie chart
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Vote results"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius: MediaQuery.of(context).size.width / 2,
            ringStrokeWidth: 24,
            animationDuration: const Duration(seconds: 3),
            chartValuesOptions: const ChartValuesOptions(
                showChartValues: true,
                showChartValuesOutside: true,
                showChartValuesInPercentage: true,
                showChartValueBackground: false),
            legendOptions: const LegendOptions(
                showLegends: true,
                legendShape: BoxShape.rectangle,
                legendTextStyle: TextStyle(fontSize: 15),
                legendPosition: LegendPosition.bottom,
                showLegendsInRow: true),
            gradientList: gradientList,
          ),
        ),
      ),
    );
  }
}
