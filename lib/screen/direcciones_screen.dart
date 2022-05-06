import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';
import '../themes/app_theme.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(
          Icons.home_outlined,
          color: AppTheme.primary,
        ),
        title: Text(scanListProvider.scans[index]!.valor),
        subtitle: Text(scanListProvider.scans[index]!.id.toString()),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {},
      ),
      itemCount: scanListProvider.scans.length,
    );
  }
}
