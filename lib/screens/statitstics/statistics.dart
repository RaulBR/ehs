import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  // final List<LinearSales> a = [
  //   LinearSales(0218, 3240),
  //   LinearSales(2020, 3240),
  //   LinearSales(2019, 3240),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stats')),
        body: Container(
            color: AppColors.icons,
            child: Text('')) //DonutPieChart.withSampleData())
        );
  }
}
