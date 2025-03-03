import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.lat,
    required this.lng,
    this.onTap,
    this.isSelecting = false,
  });

  final double? lat;
  final double? lng;
  final void Function(TapPosition tapPosition, LatLng point)? onTap;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(widget.lat ?? 51.509865, widget.lng ?? -0.118092),
              initialZoom: 13.0,
              onTap: widget.isSelecting
                  ? (tapPosisiton, point) {
                      _selectLocation(point);
                      widget.onTap!(tapPosisiton, point);
                    }
                  : null,
              // onTap: widget.isSelecting
              //     ? (tapPosition, point) => _selectLocation(point)
              //     : widget.onTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              if (!widget.isSelecting)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(widget.lat!, widget.lng!),
                      child: const Icon(Icons.location_on),
                    ),
                  ],
                ),
              if (widget.isSelecting && _pickedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _pickedLocation!,
                      child: const Icon(Icons.location_on),
                    ),
                  ],
                ),
            ],
          ),
          if (widget.isSelecting)
            Align(
              alignment: Alignment.bottomCenter,
              child: Positioned(
                child: ElevatedButton(
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
