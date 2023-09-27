import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/functions/db_functions.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/theme/theme_manager.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart'),
        backgroundColor: themeManager.primaryColor,
      ),
      body: Column(
        children: [
          FutureBuilder<List<TaskModel>>(
            future: getAlltasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                int completedTasks =
                    snapshot.data!.where((task) => task.tasComplete).length;
                int incompletedTasks =
                    snapshot.data!.where((task) => !task.tasComplete).length;
                 return Center(
                   child: Container(
                   width: 350, 
                   height: 350,
                   child: PieChart(
                     PieChartData(
                       sections: [
                         PieChartSectionData(
                           value: completedTasks.toDouble(),
                           color: Color.fromARGB(255, 14, 2, 121),
                           
                         ),
                         PieChartSectionData(
                           value: incompletedTasks.toDouble(),
                           color: const Color.fromARGB(255, 54, 206, 244),
                         ),
                       ],
                       sectionsSpace: 2,
                       centerSpaceRadius: 90,
                       startDegreeOffset: 90,
                       
                     ),
                   ),
                              ),
                 );
              
              }
            },
          ),
          SizedBox(height: 20,),
          chartValues(color: Color.fromARGB(255, 14, 2, 121),text: "Completed Task's"),
          SizedBox(height: 40,),
          chartValues(color: const Color.fromARGB(255, 54, 206, 244),text: "Incomplete Task's")
        ],
        
      ),
    );
  }

  Row chartValues({required Color color,String? text}) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(7)),
            ),
            SizedBox(width: 15,),
            Text(text!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),)
          ],
        );
  }
}
