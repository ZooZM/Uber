import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/utils/app_fun.dart';
import 'package:uber/core/utils/location_service.dart';
import 'package:uber/features/home/presentation/view/widgets/location_arrow.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_pick_up_location_cubit.dart';

class BackgroundMap extends StatefulWidget {
  final Function(LatLng center)? onCenterChanged;

  const BackgroundMap({super.key, this.onCenterChanged});

  @override
  State<BackgroundMap> createState() => _BackgroundMapState();
}

class _BackgroundMapState extends State<BackgroundMap> {
  late CameraPosition initialCameraPoistion;
  late GoogleMapController _mapController;
  late LocationService _locationService;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(26.820553, 30.802498),
    zoom: 6,
  );

  @override
  void initState() {
    initialCameraPoistion = const CameraPosition(
      target: LatLng(26.820553, 30.802498),
      zoom: 6,
    );
    _locationService = LocationService();
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
    } catch (e) {
      // التعامل مع LocationEnabledException و LocationPermissionException
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

  void _updateMarkers(LatLng? pickup, LatLng? dropoff) {
    _markers.clear();
    _polylines.clear();

    if (pickup != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickup,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: InfoWindow(title: '🚕 Pickup'),
        ),
      );
    }

    if (dropoff != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: dropoff,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    if (pickup != null && dropoff != null) {
      _drawRoute(pickup, dropoff);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pickupState = context.watch<GetPickUpLocationCubit>().state;
    final dropoffState = context.watch<GetDropOffLocationCubit>().state;

    LatLng? pickup;
    LatLng? dropoff;

    if (pickupState is GetPickUpLocationSuccess) {
      pickup = LatLng(
        pickupState.location.coordinates.lat!,
        pickupState.location.coordinates.lng!,
      );
    }

    if (dropoffState is GetDropOffLocationSuccess) {
      dropoff = LatLng(
        dropoffState.location.coordinates.lat!,
        dropoffState.location.coordinates.lng!,
      );
    }

    _updateMarkers(pickup, dropoff);
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
    final pickupState = context.watch<GetPickUpLocationCubit>().state;
    final dropoffState = context.watch<GetDropOffLocationCubit>().state;
    if (pickupState is GetPickUpLocationChoose ||
        dropoffState is GetDropOffLocationChoose) {
      polylineCoordinates.clear();
      animatedPolyline.clear();
    }
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
          onCameraMove: (position) {
            setState(() {
              widget.onCenterChanged?.call(position.target);
            });
          },
          onCameraIdle: () => setState(() {}),
        ),

        Positioned(
          right: 16,
          bottom: 250,
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
