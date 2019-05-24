import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String typeMap = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createButtonFloat(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _createMap(),
        _createMarkes(scan)
      ],
    );

  }

   _createMap() {
     return TileLayerOptions(
       urlTemplate: 'https://api.mapbox.com/v4/'
       '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
       additionalOptions: {
         'accessToken': 'pk.eyJ1IjoiY2FybGluc2s4IiwiYSI6ImNqdzJtdTdyNTA1MDU0NGw5ZXhqeHkyOGYifQ.riy6PwWNt0uXvG3DxevqxA',
         'id':'mapbox.$typeMap'
         
       }
     );
   }

  _createMarkes(ScanModel scan) {

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          height: 100.0,
          width: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0, 
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ],
    );

  }

  Widget _createButtonFloat(BuildContext context) {

    return FloatingActionButton(
      onPressed: (){
        //steets, dark, light, outdoors, satellite
        if(typeMap=='streets'){
          typeMap='dark';
        }else if(typeMap=='dark'){
          typeMap='light';
        }else if(typeMap=='light'){
          typeMap='outdoors';
        }else if(typeMap=='outdoors'){
          typeMap='satellite';
        }else{
          typeMap='streets';
        }
        setState(() { });
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );

  }
}