


import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBolc{


  static final ScansBolc _singleton = new ScansBolc._internal();

  factory ScansBolc(){
    return _singleton;
  }

  ScansBolc._internal(){
    getScan();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  //GetScan
  getScan() async {

    _scansController.sink.add(await DBProvider.db.getScanAll());

  }

  //AddScan
  addScan(ScanModel scan) async {

    await DBProvider.db.nuevoScan(scan);
    getScan();

  }

  //DeleteScan
  deleteScan( int id ) async {

    await DBProvider.db.deleteScan(id);
    getScan();

  }
  //DeleteALLScan
  deleteAll() async {
    await DBProvider.db.deleteAll();
    getScan();
  }
  
}