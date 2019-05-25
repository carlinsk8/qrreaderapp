import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

import 'package:qrreaderapp/src/utils/scan_utils.dart' as utils;

class DireccionesPage extends StatelessWidget {

  final scanBloc = new ScansBolc();

  @override
  Widget build(BuildContext context) {

    scanBloc.getScan();
    
    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final scan = snapshot.data;

        if(scan.length==0){
          return Center(child: Text('No hay datos'),);
        }else{
          return ListView.builder(
            itemCount: scan.length,
            itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => scanBloc.deleteScan(scan[i].id),
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
                title: Text(scan[i].valor),
                subtitle: Text('${scan[i].id}'),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                onTap: (){
                  utils.launchURL(scan[i], context);
                },
              ),
            )
          );
        }
        
      },
    );
  }
}