import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';

class Validator {

  final validatorGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){

      final geoScan = scans.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScan);
    }
  );

  final validatorHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){

      final httpScan = scans.where((s) => s.tipo == 'http').toList();
      sink.add(httpScan);
    }
  );

}