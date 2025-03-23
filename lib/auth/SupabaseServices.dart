import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/screens/users/HomePage.dart';
import 'package:flutter_application_1/screens/users/LoginPage.dart';

final supabase = Supabase.instance.client;

class SupabaseService {
  // Initialize Supabase
  Future<void> initialize() async {
    await Supabase.initialize(
      url:
          'https://zuicmikqkapgodejaxob.supabase.co', // Replace with your Supabase URL
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1aWNtaWtxa2FwZ29kZWpheG9iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI3MDU1NzUsImV4cCI6MjA1ODI4MTU3NX0.cboQllH0cO6llyjbLHIRCgaGvKHfjGIOmrj7bMpzWt0', // Replace with your Supabase anon key
    );
  }

  // **User Registration**
  Future<void> registerUser({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
    required String profilePictureUrl,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Step 1: Register the user with Supabase Auth
      final AuthResponse authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        // Step 2: Store additional user details in the 'users' table
        await supabase.from('users').insert({
          'id': authResponse.user!.id, // Use the user ID from Auth
          'name': fullName,
          'email': email,
          'phone_number': phoneNumber,
          'role': role,
          'profile_picture': profilePictureUrl,
          'created_at': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );

        // Navigate to HomePage after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      print('Error: $e');
    }
  }

  // **Login User**
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
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
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

  // **Logout**
  Future<void> logout(BuildContext context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // **Fetch User Details**
  Future<Map<String, dynamic>?> fetchUserDetails() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    // Fetch additional user details from the 'users' table
    final response =
        await supabase.from('users').select().eq('id', user.id).single();

    return {
      "id": user.id,
      "email": user.email,
      "name": response['name'],
      "phone_number": response['phone_number'],
      "role": response['role'],
      "profile_picture": response['profile_picture'],
      "created_at": response['created_at'],
      "last_sign_in_at":
          user.lastSignInAt != null && user.lastSignInAt!.isNotEmpty
              ? DateTime.parse(user.lastSignInAt!)
                  .toIso8601String() // Parse to DateTime
              : null,
    };
  }

  // **Create a Report**
  Future<void> createReport({
    required String userId,
    required String photoUrl,
    required String location,
    required String description,
  }) async {
    await supabase.from('reports').insert({
      'user_id': userId,
      'photo_url': photoUrl,
      'location': location,
      'description': description,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // **Assign a Volunteer**
  Future<void> assignVolunteer({
    required String reportId,
    required String volunteerId,
  }) async {
    await supabase.from('assignments').insert({
      'report_id': reportId,
      'volunteer_id': volunteerId,
      'status': 'assigned',
      'assigned_at': DateTime.now().toIso8601String(),
    });
  }

  // **Register NGO**
  Future<void> createNGO({
    required String id,
    required String name,
    required String contactPerson,
    required String phoneNumber,
    required String email,
    required String location,
  }) async {
    await supabase.from('ngos').insert({
      'id': id,
      'name': name,
      'contact_person': contactPerson,
      'phone_number': phoneNumber,
      'email': email,
      'location': location,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
