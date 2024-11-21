import 'package:flutter/material.dart';
import '../controller/perpus_controller.dart';
import '../models/perpus.dart';
import '../widgets/perpus_modal.dart';


class PerpusView extends StatefulWidget {
  const PerpusView({Key? key}) : super(key: key);

  @override
  _PerpusViewState createState() => _PerpusViewState();
}

class _PerpusViewState extends State<PerpusView> {
  final PerpusController _controller = PerpusController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Perpustakaan'),
      ),
      body: ListView.builder(
        itemCount: _controller.listPerpus.length,
        itemBuilder: (context, index) {
          final perpus = _controller.listPerpus[index];
          return Card(
            child: ListTile(
              leading: perpus.gambar.isNotEmpty
                  ? Image.network(perpus.gambar, width: 50, fit: BoxFit.cover)
                  : const Icon(Icons.book),
              title: Text(perpus.judulBuku),
              subtitle: Text('Stok: ${perpus.stok}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showModal(context, perpus),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() => _controller.deletePerpus(perpus.id));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showModal(BuildContext context, [Perpus? perpus]) {
    showDialog(
      context: context,
      builder: (_) => PerpusModal(
        perpus: perpus,
        onSave: (savedPerpus) {
          setState(() {
            if (perpus == null) {
              _controller.addPerpus(savedPerpus);
            } else {
              _controller.updatePerpus(perpus.id, savedPerpus);
            }
          });
        },
      ),
    );
  }
}
