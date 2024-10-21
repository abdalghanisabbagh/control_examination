//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:package_info_plus_web/package_info_plus_web.dart';
import 'package:pdf_render/src/web/pdf_render_web_plugin.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  PackageInfoPlugin.registerWith(registrar);
  PdfRenderWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
