import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginPage.dart';
import 'package:flutter_application_1/SupabaseServices.dart';

class HomePage extends StatelessWidget {
  final SupabaseService _supabaseService = SupabaseService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Home Page"),
  backgroundColor: Colors.blue, // Ensure good contrast
  actions: [
    Padding(
      padding: EdgeInsets.only(right: 10), // Adjust spacing from right
      child: OutlinedButton.icon(
        onPressed: () async {
          await _supabaseService.logout(context); // Call logout function
        },
        icon: Icon(Icons.logout, color: Colors.white), // Logout icon
        label: Text(
          "Sign Out",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white, // Text color
          side: BorderSide(color: Colors.white, width: 2), // Border color & width
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
        ),
      ),
    ),
  ],
),

    );
  }
}
