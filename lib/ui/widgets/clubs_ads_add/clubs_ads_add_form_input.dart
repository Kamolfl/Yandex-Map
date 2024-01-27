import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:yandex_map/constants/api_key/api_key.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../generated/l10n.dart';


class ClubsAdsAddFormInput extends StatelessWidget {
  const ClubsAdsAddFormInput({super.key, required this.title, required this.controller, required this.hintText, required this.onAddressSelected});
  final String title;
  final TextEditingController  controller;
  final String hintText;
  final Function(String, LatLng) onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          if (title == S.of(context).addressByLocation)
            TextFormField(
              controller: controller,
              onTap: () async {
                Prediction? prediction = await PlacesAutocomplete.show(
                  offset: 0,
                  radius: 1000,
                  strictbounds: false,
                  region: "uz",
                  language: "uz",
                  context: context,
                  mode: Mode.overlay,
                  apiKey: apiKey,
                  components: [Component(Component.country, "uz")],
                  types: [],
                  hint: "Search City",
                );
                // Обрабатываем выбранный адрес
                if (prediction != null) {
                  PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: apiKey).getDetailsByPlaceId(prediction.placeId!);
                  LatLng position = LatLng(details.result.geometry!.location.lat, details.result.geometry!.location.lng);
                  onAddressSelected(details.result.formattedAddress ?? '', position);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF949CA9)),
              ),
            )
          else
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF949CA9)),
              ),
            ),
        ],
      ),
    );
  }
}
