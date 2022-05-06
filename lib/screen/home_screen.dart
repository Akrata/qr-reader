import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/screen/screen.dart';

import '../providers/ui_provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () async {
              final scanProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanProvider.borrarTodos();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: const Center(
        child: _HomeScreenBody(),
      ),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtener desde provider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar scanlistprovider

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const HistorialMapasScreen();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesScreen();
      default:
        scanListProvider.cargarScansPorTipo('geo');
        return const HistorialMapasScreen();
    }
  }
}
