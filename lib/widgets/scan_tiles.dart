import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/scan_list_provider.dart';
import '../themes/app_theme.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

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
          leading: Icon(
            tipo == 'geo' ? Icons.map_outlined : Icons.home_outlined,
            color: AppTheme.primary,
          ),
          title: Text(scanListProvider.scans[index]!.valor),
          subtitle: Text(scanListProvider.scans[index]!.id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () async {
            // final url = Uri.parse("https://google.com");

            // if (await canLaunchUrl(
            //   url,
            // )) {
            //   await launchUrl(
            //     url,
            //     mode: LaunchMode.platformDefault,
            //   );
            // } else {
            //   print('cant');
            // }

            lanzarUrl(context, scanListProvider.scans[index]!);
          },
        ),
      ),
      itemCount: scanListProvider.scans.length,
    );
  }
}
