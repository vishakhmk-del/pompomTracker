import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pompomtracker/model/weeklycollection/buscollectionmdl/rep_detail.dart';

class Linechartwidget extends StatelessWidget {
  const Linechartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


List<RepDetail> parseData(String jsonData) {
  final Map<String, dynamic> parsed = json.decode(jsonData);
  final List<dynamic> repDetails = parsed['rep_details'];
  return repDetails.map<RepDetail>((json) => RepDetail.fromJson(json)).toList();
}

//List<RepDetail> data = parseData(jsonData);

class Titles {
  static getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                // if(index>=0&& index<data.length){
                //   final date=data[index].date;
                //   return Text('${date.day}/${date.month}');
                // }
                return Container();
              })));
}
