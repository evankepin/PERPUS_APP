import 'package:flutter/material.dart';
import 'package:perpus_app/page/login.dart';
import 'package:perpus_app/page/manage_book.dart'; // Pastikan import halaman ManajemenBukuPage
import 'package:provider/provider.dart';
import 'package:perpus_app/provider/auth_provider.dart';

class BerandaPage extends StatefulWidget {
  final String role;
  final String name;

  const BerandaPage({
    super.key,
    required this.role,
    required this.name,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const BeritaPage(),
    const KategoriPage(),
    ProfilePage(),
  ];

  Future<void> _logout() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final success = await loginProvider.logout();

    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginProvider.errorMessage)),
      );
    }
  }

  void _navigateToManajemenBuku() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormBukuPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Berita'
              : _selectedIndex == 1
                  ? 'Kategori'
                  : 'Profil',
        ),
        backgroundColor: Colors.blue.withOpacity(0.8),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Add search functionality
              },
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.name),
              accountEmail: Text('Role: ${widget.role}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(widget.name[0].toUpperCase()),
              ),
            ),
            if (widget.role == 'admin')
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Manajemen Buku'),
                onTap: _navigateToManajemenBuku,
              ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _logout();
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Berita'));
  }
}

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Kategori'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Profil'));
  }
}
