import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_map/ui/widgets/clubs_ads_add/clubs_ads_add_description_form_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../generated/l10n.dart';
import '../widgets/clubs_ads_add/clubs_ads_add_form_input.dart';
import '../widgets/sign_up_widgets/sign_up_form_input.dart';


class ClubsAdsAdd extends StatefulWidget {
  const ClubsAdsAdd({super.key});

  @override
  State<ClubsAdsAdd> createState() => _ClubsAdsAddState();
}

class _ClubsAdsAddState extends State<ClubsAdsAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final LatLng _pGoogleplex = const LatLng(41.292437, 69.249333);
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;
  LocationPermission? permission;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      } else {
        await _getUserLocation();
      }
    } catch (e) {
      print('Ошибка MYHOMEPAGE 156: $e');
    }
  }


  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _markers.add(Marker(
              markerId: const MarkerId('current_location'),
              position: _currentLocation!));
        });
      }
      if (_mapController != null) {
        _mapController!.moveCamera(CameraUpdate.newLatLng(_currentLocation!));
      }
    } catch(e) {
      print("Error getting current location: $e");
    }
  }

  void _updateLocation(String selectedAddress, LatLng position) {
    if (mounted) {
      setState(() {
        _locationController.text = selectedAddress;
        _markers.clear();
        _markers.add(Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
        ));
        if (_mapController != null) {
          _mapController!
              .animateCamera(CameraUpdate.newLatLngZoom(position, 17));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        title: Text(S.of(context).newAds),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.blue,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SignUpFormInput(
                title: S.of(context).title,
                controller: _titleController,
                hintText: S.of(context).enterProductTitle),
            ClubsAdsAddDescriptionFormInput(
                title: S.of(context).description,
                controller: _descriptionController,
                hintText: S.of(context).enterTheDescription),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.002,
                      color: const Color(0xFF01001F),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).changeLocation),
                  ),
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.002,
                      color: const Color(0xFF01001F),
                    ),
                  ),
                ],
              ),
            ),
            ClubsAdsAddFormInput(title: S.of(context).addressByLocation, controller: _locationController, hintText: S.of(context).enterTheMapAddress, onAddressSelected: _updateLocation),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(target: _currentLocation ?? _pGoogleplex, zoom: 15),
                markers: _markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
