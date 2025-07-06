// controller/ambulanceregistration_controller.dart
import 'package:flutter/material.dart';
import 'package:rescuerun/models/ambulancemodel.dart';
import 'package:rescuerun/services/ambulanceservice.dart';

class AmbulanceRegistrationController extends ChangeNotifier {
  final AmbulanceService _service = AmbulanceService();
  bool isLoading = false;

  Future<String?> registerAmbulance(AmbulanceModel ambulance) async {
    isLoading = true;
    notifyListeners();

    try {
      await _service.registerAmbulance(ambulance);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}




// import 'package:flutter/material.dart';
// import 'package:rescuerun/models/ambulancemodel.dart';
// import 'package:rescuerun/services/ambulanceservice.dart';

// class AmbulanceRegistrationController extends ChangeNotifier {
//   final AmbulanceService _service = AmbulanceService();
//   bool isLoading = false;

//   Future<String?> registerAmbulance(AmbulanceModel ambulance) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       await _service.registerAmbulance(ambulance);
//       isLoading = false;
//       notifyListeners();
//       return null;
//     } catch (e) {
//       isLoading = false;
//       notifyListeners();
//       return e.toString();
//     }
//   }
// }
