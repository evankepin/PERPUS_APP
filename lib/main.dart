import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:perpus_app/page/welcome.dart';
import 'package:perpus_app/page/manage_book.dart';
import 'package:perpus_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:perpus_app/provider/buku_provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Aktifkan Device Preview
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()), // Tambahkan LoginProvider
          ChangeNotifierProvider(create: (_) => BukuProvider()), // Tambahkan BukuProvider
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpus App',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
