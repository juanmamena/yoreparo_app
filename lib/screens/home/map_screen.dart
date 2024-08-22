import 'dart:async';

import 'package:yoreparo_app/models/home/scan_model.dart';
import 'package:yoreparo_app/screens/screens.dart';
import 'package:yoreparo_app/utils/location_util.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ScanModel? scan;
  String? location;
  CameraPosition? puntoInicial;
  Set<Marker>? markers;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    super.initState();
    puntoInicial = const CameraPosition(
      target: LatLng(-0.191119, -78.461350),
      zoom: 7.4746,
      tilt: 50,
    );
    markers = <Marker>{};
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: puntoInicial!,
        markers: markers!,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await getCurrentLocation().then((value) {
              setState(() {
                location =
                    'geo:${value.latitude.toString()},${value.longitude.toString()}';
              });
            });
            scan = ScanModel(valor: location);
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: scan!.getLatLng(), zoom: 14.4746, tilt: 50)));
            markers!.clear();
            markers!.add(Marker(
                markerId: const MarkerId('currentLocation'),
                position: scan!.getLatLng()));
          },
          label: const Text('Ubicación actual'),
          icon: const Icon(Icons.location_history_rounded)),
    );
  }
}
