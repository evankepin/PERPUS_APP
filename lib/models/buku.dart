

class Buku {
  final int id;
  final String judul;
  final String penulis;
  final int tahunTerbit;

  Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahunTerbit,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      judul: json['judul'],
      penulis: json['penulis'],
      tahunTerbit: json['tahun_terbit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'penulis': penulis,
      'tahun_terbit': tahunTerbit,
    };
  }
}
