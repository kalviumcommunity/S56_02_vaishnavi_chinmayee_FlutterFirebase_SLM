import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

import '../core/theme.dart';
import '../widgets/stat_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Dashboard",

            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // STAT CARDS
          Row(
            children: [
              StatCard(
                title: "Total Books",
                icon: Icons.menu_book,
                stream: FirebaseFirestore.instance
                    .collection("books")
                    .snapshots(),
              ),

              StatCard(
                title: "Issued Books",
                icon: Icons.bookmark,
                stream: FirebaseFirestore.instance
                    .collection("transactions")
                    .where("status", isEqualTo: "issued")
                    .snapshots(),
              ),

              StatCard(
                title: "Returned",
                icon: Icons.assignment_return,
                stream: FirebaseFirestore.instance
                    .collection("transactions")
                    .where("status", isEqualTo: "returned")
                    .snapshots(),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // CHART
          Container(
            height: 300,

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: AppColors.card,

              borderRadius: BorderRadius.circular(16),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),

            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,

                borderData: FlBorderData(show: false),

                gridData: FlGridData(show: true),

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,

                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return const Text("Books");

                          case 1:
                            return const Text("Issued");

                          case 2:
                            return const Text("Returned");
                        }

                        return const Text("");
                      },
                    ),
                  ),
                ),

                barGroups: [
                  BarChartGroupData(
                    x: 0,

                    barRods: [
                      BarChartRodData(toY: 12, color: Colors.blue, width: 20),
                    ],
                  ),

                  BarChartGroupData(
                    x: 1,

                    barRods: [
                      BarChartRodData(toY: 7, color: Colors.orange, width: 20),
                    ],
                  ),

                  BarChartGroupData(
                    x: 2,

                    barRods: [
                      BarChartRodData(toY: 5, color: Colors.green, width: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
