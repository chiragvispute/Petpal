import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/SupabaseServices.dart';
import 'package:flutter_application_1/screens/users/RegisterPage.dart';

class Loginpage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Loginpage({super.key});

  @override
  Widget build(BuildContext context_) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Color(0xFF222831),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/expenses.png', height: 80),
                SizedBox(height: 10),
                Text("PetPal",
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 30),
                Text("Welcome Back!",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 20),
                _buildTextField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email),
                SizedBox(height: 15),
                _buildTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    icon: Icons.lock,
                    isPassword: true),
                SizedBox(height: 24),
                _buildButton(
                    text: "Login",
                    onPressed: () async {
                      await SupabaseService().loginUser(
                        context: context_,
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    }),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context_,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
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
      child:
          Text(text, style: TextStyle(fontSize: 18, color: Color(0xFF222831))),
    );
  }
}
