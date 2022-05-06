import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   false,
        //   ScanMode.QR,
        // );

        const String barcodeScanRes = 'https://google.com';
        const String barcodeScanRes2 = 'geo:15.33,15.66';
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan(barcodeScanRes2);
      },
      child: const Icon(Icons.filter_center_focus_outlined),
    );
  }
}
