import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel?> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    final getScans = await DBProvider.db.getAllScans();
    scans = [...getScans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final getScans = await DBProvider.db.getScansByTipo(tipo);
    scans = [...getScans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarScan(int id) async {
    final delScan = await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }
}
