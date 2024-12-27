import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class UserHomePage extends StatefulWidget {
  final String name;
  const UserHomePage({super.key, required this.name, required String role});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const BeritaPage(),
    const KategoriPage(),
    const ProfilePage(),
  ];

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
          _selectedIndex == 0 ? 'Bacaan Pilihan' : _selectedIndex == 1 ? 'Kategori' : 'Profil Pengguna',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple.withOpacity(0.8),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchNews(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotifications(context);
            },
          ),
        ],
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/welcome.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'News Reader',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blueAccent),
              title: const Text('Home', style: TextStyle(fontWeight: FontWeight.w600),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.green),
              title: const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/KategoriPage');
              },
            ),
             ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (Route<dynamic> route) => false,
                );
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
            label: 'Buku',
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
        showUnselectedLabels: true,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _searchNews(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Search News"),
          content: const Text("Masukkan kata kunci buku yang ingin dicari."),
          actions: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Keyword',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notifications"),
          content: const Text("Tidak ada notifikasi buku baru."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildNewsCard(
        context,
        imageUrl: 'assets/images/dilan.jpg',
        title: 'Novel Dilan 1990',
        description: 'Cinta remaja terasa begitu murni dan penuh semangat. Kisahnya berpusat pada Dilan, seorang pemuda Bandung yang dikenal dengan sifatnya yang unik dan penuh kejutan, serta Milea, gadis pindahan dari Jakarta yang berhasil mencuri hatinya.',
      ),
        const SizedBox(height: 10),
        _buildNewsCard(
          context,
          imageUrl: 'assets/images/sejarah.jpg',
          title: 'Sejarah Nusantara',
          description: 'Nusantara, atau kepulauan Indonesia, memiliki sejarah yang kaya dan kompleks, membentang ribuan tahun. Peradaban di sini telah berkembang seiring dengan interaksi dengan berbagai budaya dari Asia dan sekitarnya.',
        ),
        const SizedBox(height: 10),
        _buildNewsCard(
          context,
          imageUrl: 'assets/images/secienc.jpg',
          title: 'Buku Sains',
          description: 'Sains adalah cara sistematis untuk memahami dunia di sekitar kita. Sains melibatkan pengamatan, eksperimen, dan analisis data untuk menemukan pola dan menjelaskan fenomena alam.',
        ),
        const SizedBox(height: 10),
        _buildNewsCard(
          context,
          imageUrl: 'assets/images/hukum.jpg',
          title: 'Buku Hukum',
          description: 'Hukum adalah seperangkat aturan yang mengatur perilaku manusia dalam masyarakat. Aturan ini dibuat untuk menciptakan ketertiban, keadilan, dan keamanan bersama. Hukum bisa berupa undang-undang, peraturan daerah, hingga norma-norma yang berlaku dalam suatu komunitas.',
        ),
      ],
    );
  }

  Widget _buildNewsCard(BuildContext context, {required String imageUrl, required String title, required String description}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBeritaPage(
              imageUrl: imageUrl,
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailBeritaPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const DetailBeritaPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Konten Lengkap:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Kategori Page
class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*       appBar: AppBar(
        title: const Text('Kategori Buku'),
        backgroundColor: Colors.brown,
      ), */
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            _buildCategoryCard(
              icon: Icons.book,
              title: 'Novel',
              gradientColors: [Colors.pinkAccent, Colors.pink],
            ),
            _buildCategoryCard(
              icon: Icons.history,
              title: 'Sejarah',
              gradientColors: [Colors.brown, Colors.orangeAccent],
            ),
            _buildCategoryCard(
              icon: Icons.science,
              title: 'Science',
              gradientColors: [Colors.blueAccent, Colors.lightBlue],
            ),
            _buildCategoryCard(
              icon: Icons.business,
              title: 'Ekonomi & Bisnis',
              gradientColors: [Colors.green, Colors.teal],
            ),
            _buildCategoryCard(
              icon: Icons.gavel,
              title: 'Hukum',
              gradientColors: [Colors.deepPurple, Colors.purple],
            ),
            _buildCategoryCard(
              icon: Icons.psychology,
              title: 'Filsafat',
              gradientColors: [Colors.indigo, Colors.blue],
            ),
            _buildCategoryCard(
              icon: Icons.biotech,
              title: 'Biologi',
              gradientColors: [Colors.lightGreen, Colors.green],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required List<Color> gradientColors,
  }) => Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigasi ke halaman detail kategori
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.last.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 60, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/profile.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Evana Anugrah Purwayanto',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Evan@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementasi navigasi ke halaman edit profil
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Warna tombol
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Sudut tombol
                  ),
                ),
                child: const Text(
                  'Edit Profil',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Tambahan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Bio: Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                      SizedBox(height: 5),
                      Text('Bergabung: Januari 2024'),
                      SizedBox(height: 5),
                      Text('Jumlah Artikel: 15'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}