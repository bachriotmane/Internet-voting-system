import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VotePieChart extends StatefulWidget {
  @override
  _VotePieChartState createState() => _VotePieChartState();
}

class _VotePieChartState extends State<VotePieChart> {
  // Example vote data for programs
  final Map<String, double> programVotes = {
    "Program A": 40,
    "Program B": 30,
    "Program C": 20,
    "Program D": 10,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Pie Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: PieChart(
            PieChartData(
              sections: showingSections(),
              centerSpaceRadius: 40,
              borderData: FlBorderData(
                show: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double totalVotes = programVotes.values.reduce(
      (a, b) => a + b,
    );
    return programVotes.entries.map((entry) {
      final double percentage = (entry.value / totalVotes) * 100;
      return PieChartSectionData(
        color: _getColor(entry.key),
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getColor(String programName) {
    switch (programName) {
      case "Program A":
        return Colors.red;
      case "Program B":
        return Colors.blue;
      case "Program C":
        return Colors.green;
      case "Program D":
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
