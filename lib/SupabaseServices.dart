import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginPage.dart';
import 'package:flutter_application_1/HomePage.dart'; // Import HomePage
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://xqlzeqqnoppctqyywnsm.supabase.co', // Your Supabase project URL
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhxbHplcXFub3BwY3RxeXl3bnNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MTIxMjgsImV4cCI6MjA1NTE4ODEyOH0.fxot9GiTT6wj73eXb9L37hlnDPfXQh0el1GBju3TLtY', // Your Supabase anon key
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  // Register User Function
  Future<void> registerUser({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final AuthResponse response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Login Function
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final AuthResponse response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      print(e.toString());
    }
  }

  // Fetch User Details Function
  Future<Map<String, dynamic>?> fetchUserDetails() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return null;

    return {
      "email": user.email,
      "createdAt": user.createdAt.toString(),
      "lastSignInAt": user.lastSignInAt.toString(),
    };
  }

  // Logout Function
  Future<void> logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Loginpage()), // Navigate back to LoginPage after logout
    );
  }
}
