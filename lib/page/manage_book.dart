import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:perpus_app/models/buku.dart';
import 'package:perpus_app/provider/buku_provider.dart';

class FormBukuPage extends StatefulWidget {
  const FormBukuPage({super.key});

  @override
  _ManajemenBukuPageState createState() => _ManajemenBukuPageState();
}

class _ManajemenBukuPageState extends State<FormBukuPage> {
  final _formKey = GlobalKey<FormState>();
  late String _judul;
  late String _penulis;
  late int _tahunTerbit;

  @override
  void initState() {
    super.initState();
    final bukuProvider = Provider.of<BukuProvider>(context, listen: false);
    bukuProvider.fetchBukus();
  }

  void _showForm([Buku? buku]) {
    if (buku != null) {
      _judul = buku.judul;
      _penulis = buku.penulis;
      _tahunTerbit = buku.tahunTerbit;
    } else {
      _judul = '';
      _penulis = '';
      _tahunTerbit = 0;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(buku == null ? 'Tambah Buku' : 'Edit Buku'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _judul,
                  decoration: const InputDecoration(labelText: 'Judul'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) => _judul = value!,
                ),
                TextFormField(
                  initialValue: _penulis,
                  decoration: const InputDecoration(labelText: 'Penulis'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Penulis tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) => _penulis = value!,
                ),
                TextFormField(
                  initialValue: _tahunTerbit != 0 ? _tahunTerbit.toString() : '',
                  decoration: const InputDecoration(labelText: 'Tahun Terbit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tahun Terbit tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) => _tahunTerbit = int.parse(value!),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final bukuProvider = Provider.of<BukuProvider>(context, listen: false);
                  if (buku == null) {
                    // Tambah Buku
                    bukuProvider.addBuku(Buku(id: 0, judul: _judul, penulis: _penulis, tahunTerbit: _tahunTerbit));
                  } else {
                    // Edit Buku
                    bukuProvider.updateBuku(Buku(id: buku.id, judul: _judul, penulis: _penulis, tahunTerbit: _tahunTerbit));
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(buku == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bukuProvider = Provider.of<BukuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Buku'),
      ),
      body: bukuProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : bukuProvider.errorMessage.isNotEmpty
              ? Center(child: Text(bukuProvider.errorMessage))
              : ListView.builder(
                  itemCount: bukuProvider.bukus.length,
                  itemBuilder: (context, index) {
                    Buku buku = bukuProvider.bukus[index];
                    return ListTile(
                      title: Text(buku.judul),
                      subtitle: Text('Penulis: ${buku.penulis} | Tahun Terbit: ${buku.tahunTerbit}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          bukuProvider.deleteBuku(buku.id);
                        },
                      ),
                      onTap: () {
                        _showForm(buku);
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
