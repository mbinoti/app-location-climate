import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissão negada. Trate isso de acordo com a sua necessidade.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // As permissões são negadas para sempre, não podemos solicitar permissões.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // Quando chegamos aqui, temos as permissões e podemos obter a localização do usuário.
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
