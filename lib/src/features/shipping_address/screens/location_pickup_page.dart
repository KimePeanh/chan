import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:lady_skin/src/appLocalizations.dart';

import 'address_form_page.dart';

class LocationPickupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
        region: "KH",
        selectInitialPosition: true,
        enableMyLocationButton: true,
        useCurrentLocation: true,
        apiKey: "AIzaSyCu-PFq4h9S7gKPYWcrvDaJdsnoqUZT8og",
        initialPosition: LatLng(-33.8567844, 151.213108),
        selectedPlaceWidgetBuilder: (contex, result, searchState, a) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.all(20),
                  child: (searchState == SearchingState.Searching)
                      ? Center(child: CircularProgressIndicator())
                      : Text(result!.formattedAddress!),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: AspectRatio(
                    aspectRatio: 10 / 1.3,
                    child: Container(
                        width: double.infinity,
                        height: 45,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: () async {
                            AddressFormPageState.lat =
                                result!.geometry!.location.lat.toString();
                            AddressFormPageState.long =
                                result.geometry!.location.lng.toString();
                            AddressFormPageState.addressDetailTextController
                                .text += result.formattedAddress.toString();
                            AddressFormPageState.city =
                                result.addressComponents![2].longName;

                            result.addressComponents!.forEach((element) {
                              if (element.types[0] ==
                                  "administrative_area_level_1") {
                                AddressFormPageState.city = element.longName;
                              }
                            });

                            // Dio _dio = Dio();
                            // try {
                            //   Response response = await _dio.get(
                            //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=${result.geometry.location.lat},${result.geometry.location.lng}&key=AIzaSyC3LZNYyDgypDUIL6FVbYwBLu3yoUuxbWM");
                            //
                            // } catch (_) {
                            //   Navigator.of(context).pop();
                            // }

                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              (AppLocalizations.of(context)!
                                  .translate('select')),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 1),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
