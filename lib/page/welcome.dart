import 'package:flutter/material.dart';
import 'package:perpus_app/page/login.dart';
import 'package:perpus_app/page/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten Utama
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gambar utama
                  Image.network(
                    'https://raw.githubusercontent.com/evankepin/gambar-pemro/refs/heads/main/gambar_main2.png',
                    height: 350,
                    width: 500,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Teks utama
                  const Text(
                    'PERPUSTAKAAN DIGITAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 42, 86, 161),
                    ),
                  ),
                  const Text(
                    'AYO BACA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 42, 86, 161),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Knowledge, Piety, Integrity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 12),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Tombol Register
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Teks Syarat & Ketentuan dan Kebijakan Privasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Syarat & Ketentuan ditekan");
                        },
                        child: const Text(
                          'Syarat & Ketentuan',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Text(' atau '),
                      GestureDetector(
                        onTap: () {
                          print("Kebijakan Privasi ditekan");
                        },
                        child: const Text(
                          'Kebijakan Privasi',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
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
