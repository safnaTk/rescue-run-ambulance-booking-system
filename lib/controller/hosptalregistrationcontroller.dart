import 'package:flutter/material.dart';
import 'package:rescuerun/models/hospitalmodel.dart';
import 'package:rescuerun/services/hospitalservice.dart';

class HospitalRegistrationController extends ChangeNotifier {
  final HospitalService _service = HospitalService();
  bool isLoading = false;

  Future<String?> registerHospital(HospitalModel hospital) async {
    isLoading = true;
     print("🔄 isLoading = true");
    notifyListeners();
     await Future.delayed(Duration(seconds: 2)); 

    final error = await _service.registerUser(hospital);

    isLoading = false;
    notifyListeners();
    return error;
  }
}
