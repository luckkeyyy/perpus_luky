// models/perpus.dart
class Perpus {
  final int id;
  String judulBuku;
  String deskripsiBuku;
  int stok;
  String penerbit;
  String pengarang;
  String gambar;

  Perpus({
    required this.id,
    required this.judulBuku,
    required this.deskripsiBuku,
    required this.stok,
    required this.penerbit,
    required this.pengarang,
    required this.gambar,
  });
}
