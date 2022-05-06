import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/themes/app_theme.dart';

import '../providers/scan_list_provider.dart';

class HistorialMapasScreen extends StatelessWidget {
  const HistorialMapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red[300],
        ),
        onDismissed: (DismissDirection direction) {
          scanListProvider.borrarScan(scanListProvider.scans[index]!.id!);
        },
        child: ListTile(
          leading: const Icon(
            Icons.map_outlined,
            color: AppTheme.primary,
          ),
          title: Text(scanListProvider.scans[index]!.valor),
          subtitle: Text(scanListProvider.scans[index]!.id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () async {},
        ),
      ),
      itemCount: scanListProvider.scans.length,
    );
  }
}
