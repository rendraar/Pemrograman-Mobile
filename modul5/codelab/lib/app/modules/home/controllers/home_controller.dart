import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString locationMessage = "let's trace your sme..\ni - i mean your location!!".obs;
  RxBool loading = false.obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    loading.value = true;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      currentPosition.value = position;
      locationMessage.value =
      "Latitude: ${position.latitude}\nLongitude: ${position.longitude}";
    } catch (e) {
      locationMessage.value = 'Gagal mendapatkan lokasi';
    } finally {
      loading.value = false;
    }
  }

  void openGoogleMaps() {
    if (currentPosition.value != null) {
      final url =
          'https://www.google.com/maps?q=${currentPosition.value!.latitude},${currentPosition.value!.longitude}';
      _launchURL(url);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

