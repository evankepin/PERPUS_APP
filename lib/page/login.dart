import 'package:flutter/material.dart';
import 'package:perpus_app/page/beranda.dart';
import 'package:perpus_app/page/home.dart';
import 'package:perpus_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;

  Future<void> _login() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    final email = _emailController.text;
    final password = _passwordController.text;

    final success = await loginProvider.login(email, password);
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role') ?? '';
    final name = prefs.getString('name') ?? '';

    if (success) {
      if (role == 'customer') {Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomePage(role: role,
            name: name,),
        ),
      );
      }
      if (role == 'admin') {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BerandaPage(
            role: role,
            name: name,
          ),
        ),
      );
      }
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginProvider.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Logo
                  Image.network(
                    'https://raw.githubusercontent.com/evankepin/gambar-pemro/refs/heads/main/Buku%20_%20Domain%20publik%20vektor.jpeg',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'PERPUSDA PBG LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(221, 33, 94, 152),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Username Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email or Username',
                      labelStyle: const TextStyle(color: Colors.black87),
                      hintText: 'Masukan Email atau Username Anda',
                      prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black87),
                      prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                      suffixIcon: const Icon(Icons.visibility, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Remember Me and Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Forgot Password?");
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      onPressed: loginProvider.isLoading ? null : _login,
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: loginProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer Text
                  const Text(
                    'Don\'t have an account? Contact your admin.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
