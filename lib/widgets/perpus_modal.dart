import 'package:flutter/material.dart';
import '../models/perpus.dart';

class PerpusModal extends StatefulWidget {
  final Perpus? perpus;
  final Function(Perpus) onSave;

  const PerpusModal({Key? key, this.perpus, required this.onSave}) : super(key: key);

  @override
  _PerpusModalState createState() => _PerpusModalState();
}

class _PerpusModalState extends State<PerpusModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  late TextEditingController _stokController;
  late TextEditingController _penerbitController;
  late TextEditingController _pengarangController;
  String? _selectedGambar;

  // Daftar gambar sampul yang tersedia di assets
  final List<String> _gambarAssets = [
    'assets/dilan.jpeg',

  ];
  
  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.perpus?.judulBuku ?? '');
    _deskripsiController = TextEditingController(text: widget.perpus?.deskripsiBuku ?? '');
    _stokController = TextEditingController(text: widget.perpus?.stok.toString() ?? '');
    _penerbitController = TextEditingController(text: widget.perpus?.penerbit ?? '');
    _pengarangController = TextEditingController(text: widget.perpus?.pengarang ?? '');
    _selectedGambar = widget.perpus?.gambar ?? _gambarAssets.first;
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    _stokController.dispose();
    _penerbitController.dispose();
    _pengarangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.perpus == null ? 'Tambah Buku' : 'Edit Buku'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
                validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi Buku'),
                validator: (value) => value!.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stok Buku'),
                validator: (value) => value!.isEmpty ? 'Stok tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _penerbitController,
                decoration: const InputDecoration(labelText: 'Penerbit'),
                validator: (value) => value!.isEmpty ? 'Penerbit tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _pengarangController,
                decoration: const InputDecoration(labelText: 'Pengarang'),
                validator: (value) => value!.isEmpty ? 'Pengarang tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGambar,
                items: _gambarAssets
                    .map((gambar) => DropdownMenuItem(
                          value: gambar,
                          child: Row(
                            children: [
                              Image.asset(gambar, width: 50, height: 50, fit: BoxFit.cover),
                              const SizedBox(width: 10),
                              Text(gambar.split('/').last),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGambar = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Pilih Sampul Buku'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final perpus = Perpus(
                id: widget.perpus?.id ?? DateTime.now().millisecondsSinceEpoch,
                judulBuku: _judulController.text,
                deskripsiBuku: _deskripsiController.text,
                stok: int.parse(_stokController.text),
                penerbit: _penerbitController.text,
                pengarang: _pengarangController.text,
                gambar: _selectedGambar!,
              );
              widget.onSave(perpus);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
