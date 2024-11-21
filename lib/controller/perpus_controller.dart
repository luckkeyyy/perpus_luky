// controllers/perpus_controller.dart
import '../models/perpus.dart';

class PerpusController {
  List<Perpus> _listPerpus = [];

  List<Perpus> get listPerpus => _listPerpus;

  void addPerpus(Perpus perpus) {
    _listPerpus.add(perpus);
  }

  void updatePerpus(int id, Perpus updatedPerpus) {
    int index = _listPerpus.indexWhere((perpus) => perpus.id == id);
    if (index != -1) {
      _listPerpus[index] = updatedPerpus;
    }
  }

  void deletePerpus(int id) {
    _listPerpus.removeWhere((perpus) => perpus.id == id);
  }
}
