


import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/bloc/validator.dart';

class ScansBolc with Validator{


  static final ScansBolc _singleton = new ScansBolc._internal();

  factory ScansBolc(){
    return _singleton;
  }

  ScansBolc._internal(){
    getScan();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validatorGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validatorHttp); 
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