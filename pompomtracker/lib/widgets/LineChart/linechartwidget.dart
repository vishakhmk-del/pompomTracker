import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pompomtracker/model/weeklycollection/buscollectionmdl/rep_detail.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollect.dart';

class Linechartwidget extends StatefulWidget {
   const Linechartwidget({super.key,required this.repDetails});
 final  List<Buswklycollectlist> repDetails;

  @override
  State<Linechartwidget> createState() => _LinechartwidgetState();
}

class _LinechartwidgetState extends State<Linechartwidget> {

  late List<Buswklycollectlist> data=[];

  @override
  void initState(){
    //parseDate();
    data=widget.repDetails;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData:FlTitlesData(
            bottomTitles: AxisTitles(
             sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                  final index=value.toInt();
                  if(index>= 0 && index<data.length){
                    final date=data[index].paydate;
                    print(date);

                  }
                  return Container();
              }
            
             )
             )
          )
           )),
    );
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
                //final length=data.length;
                final index = value.toInt();
                // if(index>=0&& index<data.length){
                //   final date=data[index].date;
                //   return Text('${date.day}/${date.month}');
                // }
                return Container();
              })));
}
