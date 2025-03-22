import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/SupabaseServices.dart';

class RegisterScreen extends StatelessWidget {
  final SupabaseService supabaseService = SupabaseService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Color(0xFF222831),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/profile.png', height: 80),
                SizedBox(height: 10),
                Text("PetPal",
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 30),

                Text("Create Account",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 8),
                Text("Sign up to get started!",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 20),

                // Full Name Field
                _buildTextField(
                    controller: _fullNameController,
                    hintText: "Full Name",
                    icon: Icons.person),
                SizedBox(height: 15),

                // Email Field
                _buildTextField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email),
                SizedBox(height: 15),

                // Password Field
                _buildTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    icon: Icons.lock,
                    isPassword: true),
                SizedBox(height: 24),

                // Sign Up Button
                _buildButton(
                    text: "Sign Up",
                    onPressed: () async {
                      await supabaseService.registerUser(
                        context: context,
                        fullName: _fullNameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    }),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Have an account?? Login",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required IconData icon,
      bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 241, 8, 225),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 18, color: Color(0xFF222831))),
    );
  }
}
