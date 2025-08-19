import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/auth/data/models/user_strorge.dart';
import 'package:uber/core/utils/app_fun.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/utils/location_service.dart';
import '../../../../../user/home/presentation/view/widgets/location_arrow.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({super.key});

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  late CameraPosition initialCameraPoistion;
  late GoogleMapController _mapController;
  late LocationService _locationService;

  late final icon;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(26.820553, 30.802498),
    zoom: 6,
  );
  void builMarcker() async {
    icon = await getMarkerIcon("assets/vehicle.png", 200);
  }

  Future<BitmapDescriptor> getMarkerIcon(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final bytes = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!;
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  @override
  void initState() {
    initialCameraPoistion = const CameraPosition(
      target: LatLng(26.820553, 30.802498),
      zoom: 6,
    );
    _locationService = LocationService();
    builMarcker();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _updateCurrentLocation() async {
    try {
      setState(() {});
      final current = await _locationService.getLocation();
      final position = LatLng(current.latitude!, current.longitude!);

      await _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 18),
        ),
      );
      await UserStorage.updateUserData(
        coord: [position.latitude, position.longitude],
      );
    } catch (e) {
    } finally {
      setState(() {});
    }
  }

  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_KEY']!;
    final result = await PolylinePoints(apiKey: apiKey)
        .getRouteBetweenCoordinates(
          request: PolylineRequest(
            origin: PointLatLng(start.latitude, start.longitude),
            destination: PointLatLng(end.latitude, end.longitude),
            mode: TravelMode.driving,
          ),
        );

    if (result.points.isEmpty) return;

    final List<LatLng> points = result.points
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    final distance = AppFun.calculateDistance(
      points.last.latitude,
      points.last.longitude,
      end.latitude,
      end.longitude,
    );

    if (distance < 30) {
      final mid = LatLng(
        (points.last.latitude + end.latitude) / 2,
        (points.last.longitude + end.longitude) / 2,
      );
      points.addAll([mid, end]);
    } else if (points.last != end) {
      points.add(end);
    }

    setState(() {
      polylineCoordinates = points;
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: kBlack,
          width: 6,
          jointType: JointType.round,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true,
          points: points,
        ),
      );
    });
    animatePolyline();
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            points.map((e) => e.latitude).reduce((a, b) => a < b ? a : b),
            points.map((e) => e.longitude).reduce((a, b) => a < b ? a : b),
          ),
          northeast: LatLng(
            points.map((e) => e.latitude).reduce((a, b) => a > b ? a : b),
            points.map((e) => e.longitude).reduce((a, b) => a > b ? a : b),
          ),
        ),
        160,
      ),
    );
  }

  List<LatLng> polylineCoordinates = [];
  List<LatLng> animatedPolyline = [];

  void animatePolyline() async {
    animatedPolyline.clear();
    for (int i = 0; i < polylineCoordinates.length; i++) {
      await Future.delayed(const Duration(milliseconds: 5));
      animatedPolyline.add(polylineCoordinates[i]);
      setState(() {});
    }
  }

  Set<Polyline> _buildPolylines() {
    return {
      Polyline(
        polylineId: const PolylineId("route"),
        color: kBlack,
        width: 4,
        jointType: JointType.round,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        points: animatedPolyline,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          markers: _markers,
          polylines: _buildPolylines(),
          onMapCreated: (controller) {
            _mapController = controller;
            _updateCurrentLocation();
          },
          onCameraMove: (position) {},
          onCameraIdle: () => setState(() {}),
        ),

        Positioned(
          right: 16,
          bottom: 100,
          child: LocationArrow(
            onPressed: () async {
              await _updateCurrentLocation();
            },
          ),
        ),
      ],
    );
  }
}
