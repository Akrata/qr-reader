import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

lanzarUrl(BuildContext context, ScanModel scan) async {
  final url = Uri.parse(scan.valor);

  if (scan.tipo == 'http') {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("No es posible abrir ");
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
