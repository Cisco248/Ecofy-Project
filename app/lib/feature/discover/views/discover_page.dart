// ignore_for_file: body_might_complete_normally_nullable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wms_app/feature/discover/models/discover_model.dart';
import 'package:wms_app/feature/discover/viewmodel/discover_view_model.dart';

bool isFull = false;
void capacityFinder({int val = 10, bool? status}) {
  int full = 10;
  if (val == full) {
    DebugPrint(val, "Bin Full!").log();
    status = isFull;
  } else {
    DebugPrint(val, "Still Remaining").log();
    status = !isFull;
  }
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(),
        child: Stack(
          children: [
            _MapContainer(),
            Align(alignment: Alignment.bottomCenter, child: _DashPanel()),
          ],
        ),
      ),
    );
  }
}

class _MapContainer extends ConsumerStatefulWidget {
  const _MapContainer();

  @override
  ConsumerState<_MapContainer> createState() => __MapContainerState();
}

class __MapContainerState extends ConsumerState<_MapContainer> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _pGooglePlex = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    capacityFinder();
  }

  Set<Marker> _createMarkers(List<DiscoverModel> locations) {
    return locations.map((loc) {
      return Marker(
        markerId: MarkerId(loc.markerId),
        position: LatLng(loc.latitude, loc.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(loc.hue!),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final discoverState = ref.watch(discoverViewModelProvider);
    DebugPrint(discoverState, '[DISCOVER] View Status').log();

    return SizedBox(
      height: AppSizeStyle.locateTopHeight(context),
      width: AppSizeStyle.locateTopWidth(context),
      child: discoverState == null
          ? Center(child: Text("Map Loading Error"))
          : discoverState.when(
              data: (locations) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _pGooglePlex,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _createMarkers(locations),
                  zoomControlsEnabled: true,
                  compassEnabled: true,

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    DebugPrint(controller, '[MAP] Status').log();
                  },
                );
              },
              loading: () {},
              error: (error, stack) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      Text('Error loading locations: $error'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// Todo

class _DashPanel extends StatefulWidget {
  const _DashPanel();

  @override
  State<_DashPanel> createState() => __DashPanelState();
}

class __DashPanelState extends State<_DashPanel> {
  @override
  Widget build(BuildContext context) {
    double boxSize = 16;
    double spaceSize1 = 5;
    double spaceSize2 = 30;
    var errorColor = AppColors.error;
    var successColor = AppColors.success;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBgLight,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20),
          topStart: Radius.circular(20),
        ),
      ),
      height: AppSizeStyle.locateBottomHeight(context),
      width: AppSizeStyle.locateBottomWidth(context),
      child: Column(
        spacing: spaceSize2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                spacing: spaceSize1,
                children: [
                  Container(
                    height: boxSize,
                    width: boxSize,
                    decoration: BoxDecoration(
                      color: errorColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                    'Out of Storage',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                spacing: spaceSize1,
                children: [
                  Container(
                    height: boxSize,
                    width: boxSize,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                    'Remaining Storage',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearest Garbage Bin',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Nearest Status',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' km',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  // Text("", style: Theme.of(context).textTheme.bodyLarge),
                  IconButton(
                    onPressed: () => capacityFinder(),
                    icon: Icon(Icons.add_business),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
