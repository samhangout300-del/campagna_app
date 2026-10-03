import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _username;
  List<Map<String, dynamic>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadBookings();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  Future<void> _loadBookings() async {
    final bookings = await FirebaseFirestore.instance
        .collection('bookings')
        .where('username', isEqualTo: _username)
        .get();
    setState(() {
      _bookings = bookings.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Benvenuto $_username',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  return Text(
                    "${_bookings[index]['startTime']} - ${_bookings[index]['endTime']}",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
