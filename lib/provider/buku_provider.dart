import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpus_app/models/buku.dart';

class BukuProvider with ChangeNotifier {
  List<Buku> _bukus = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Buku> get bukus => _bukus;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchBukus() async {
    _isLoading = true;
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/bukus';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _bukus = responseData.map((data) => Buku.fromJson(data)).toList();
      } else {
        _errorMessage = 'Failed to load bukus';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBuku(Buku buku) async {
    _isLoading = true;
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/bukus';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(buku.toJson()),
      );
      if (response.statusCode == 201) {
        _bukus.add(Buku.fromJson(json.decode(response.body)));
      } else {
        _errorMessage = 'Failed to add buku';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBuku(Buku buku) async {
    _isLoading = true;
    notifyListeners();

    final url = 'http://127.0.0.1:8000/api/bukus/${buku.id}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(buku.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _bukus.indexWhere((b) => b.id == buku.id);
        if (index != -1) {
          _bukus[index] = Buku.fromJson(json.decode(response.body));
        }
      } else {
        _errorMessage = 'Failed to update buku';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBuku(int id) async {
    _isLoading = true;
    notifyListeners();

    final url = 'http://127.0.0.1:8000/api/bukus/$id';

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 204) {
        _bukus.removeWhere((buku) => buku.id == id);
      } else {
        _errorMessage = 'Failed to delete buku';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
