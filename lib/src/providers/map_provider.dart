import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



const kStartPosition = LatLng(21.170814, -101.739300);
const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
const kMarkerId = MarkerId('MarkerId1');
const kDuration = Duration(seconds: 2);
const kLocations = [
  kStartPosition,
  LatLng(21.170067, -101.740830),
  LatLng(21.171429, -101.738088),
  LatLng(21.171009, -101.737852),
  LatLng(21.170099, -101.737412),
  LatLng(21.170099, -101.737412),
  LatLng(21.167871, -101.736226),
  LatLng(21.166520, -101.735582),
  LatLng(21.165730, -101.735185),
  LatLng(21.164259, -101.734434),
  LatLng(21.163248, -101.733994),
  LatLng(21.160797, -101.733050),
  LatLng(21.157885, -101.731859),
  LatLng(21.156304, -101.731247),
  LatLng(21.153732, -101.730271),
  LatLng(21.152294, -101.729761),
  LatLng(21.152734, -101.728087),
  LatLng(21.152694, -101.726553),
  LatLng(21.152454, -101.724418),
  LatLng(21.152440, -101.724576),
  LatLng(21.151930, -101.721007),
  LatLng(21.151700, -101.719741),
  LatLng(21.151720, -101.718378),
  LatLng(21.152300, -101.716672),
  LatLng(21.152920, -101.714988),
  LatLng(21.153370, -101.713578),
];



void main() => runApp(MapProvider());

class MapProvider extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapProvider> {
  final markers = <MarkerId, Marker>{};
  final _controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count]).take(kLocations.length);


    @override
      void initState() {
        stream.forEach((value) => newLocationUpdate(value));

        super.initState();
      }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1236, -101.68 ),
    zoom: 12,
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('León, Ciudad de primera'),
        actions: [
          IconButton(
            icon: Icon(Icons.alt_route),
            onPressed: (){
              Navigator.pushNamed(context, 'search');
            },
          )
        ],
      ),
      body: /*GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),*/

      Animarker(
        rippleRadius: 0.5,  //[0,1.0] range, how big is the circle
        rippleColor: Colors.blue[200], // Color of fade ripple circle
        curve: Curves.ease,
        mapId: _controller.future.then<int>((value) => value.mapId), //Grab Google Map Id
        markers: markers.values.toSet(),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: kSantoDomingo,
          onMapCreated: (gController) => _controller.complete(gController), //Complete the future GoogleMapController
        ),
      ),
    );
  }


  void newLocationUpdate(LatLng latLng) {
     var marker = RippleMarker(
       markerId: kMarkerId,
       position: latLng,
       ripple: true,
     );
     setState(() => markers[kMarkerId] = marker);
  }
}