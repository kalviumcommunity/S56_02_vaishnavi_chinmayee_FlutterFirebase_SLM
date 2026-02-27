import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'core/theme.dart';

import 'screens/dashboard.dart';
import 'screens/books_page.dart';
import 'screens/my_books_page.dart';
import 'screens/admin_dashboard.dart';
import 'screens/admin_analytics_dashboard.dart';
import 'screens/profile_page.dart';

import 'widgets/sidebar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SmartLibraryApp());
}

class SmartLibraryApp extends StatelessWidget {
  const SmartLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Smart Library",

      theme: AppTheme.lightTheme,

      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    Dashboard(),
    BooksPage(),
    MyBooksPage(),
    AdminAnalyticsDashboard(),
    AdminDashboard(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: selectedIndex,
            onSelect: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}