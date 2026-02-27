import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminAnalyticsDashboard extends StatefulWidget {
  const AdminAnalyticsDashboard({super.key});

  @override
  State<AdminAnalyticsDashboard> createState() =>
      _AdminAnalyticsDashboardState();
}

class _AdminAnalyticsDashboardState extends State<AdminAnalyticsDashboard> {
  int totalBooks = 0;
  int issuedBooks = 0;
  int returnedBooks = 0;
  int totalFine = 0;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    try {
      var books = await FirebaseFirestore.instance.collection("books").get();

      var transactions = await FirebaseFirestore.instance
          .collection("transactions")
          .get();

      int issued = 0;
      int returned = 0;
      int fine = 0;

      for (var doc in transactions.docs) {
        var data = doc.data();

        if (data["status"] == "issued") issued++;
        if (data["status"] == "returned") returned++;

        fine += (data["fine"] ?? 0) as int;
      }

      setState(() {
        totalBooks = books.docs.length;
        issuedBooks = issued;
        returnedBooks = returned;
        totalFine = fine;
        loading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Analytics"),
        backgroundColor: const Color(0xff667eea),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  Row(
                    children: [
                      statCard("Books", totalBooks, Icons.menu_book),
                      statCard("Issued", issuedBooks, Icons.bookmark),
                    ],
                  ),

                  Row(
                    children: [
                      statCard(
                        "Returned",
                        returnedBooks,
                        Icons.assignment_return,
                      ),

                      statCard("Fine ₹", totalFine, Icons.currency_rupee),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        maxY: getMaxY(),

                        barGroups: [
                          makeBar(0, totalBooks, Colors.blue),

                          makeBar(1, issuedBooks, Colors.orange),

                          makeBar(2, returnedBooks, Colors.green),

                          makeBar(3, totalFine, Colors.red),
                        ],

                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                            ),
                          ),

                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),

                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),

                        gridData: FlGridData(show: true),

                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget statCard(String title, int value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xff667eea),

          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          children: [
            Icon(icon, color: Colors.white),

            const SizedBox(height: 10),

            Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeBar(int x, int y, Color color) {
    return BarChartGroupData(
      x: x,

      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: color,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);

    switch (value.toInt()) {
      case 0:
        return const Text("Books", style: style);

      case 1:
        return const Text("Issued", style: style);

      case 2:
        return const Text("Returned", style: style);

      case 3:
        return const Text("Fine", style: style);
    }

    return const Text("");
  }

  double getMaxY() {
    int maxValue = [
      totalBooks,
      issuedBooks,
      returnedBooks,
      totalFine,
    ].reduce((a, b) => a > b ? a : b);

    return (maxValue + 5).toDouble();
  }
}
