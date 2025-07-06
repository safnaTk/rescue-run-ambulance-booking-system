import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescuerun/controller/ambulanceregistration_controller.dart';
import 'package:rescuerun/controller/hosptalregistrationcontroller.dart';

import 'firebase_options.dart';

import 'package:rescuerun/views/admin/adminhomepage.dart';
import 'package:rescuerun/views/admin/hospitalregistration.dart';
import 'package:rescuerun/views/ambulance/ambulance_homepage.dart';
import 'package:rescuerun/views/ambulance/ambulance_registration.dart';
import 'package:rescuerun/views/ambulance/location.dart';
import 'package:rescuerun/views/ambulance/sendemergencymessage.dart';
import 'package:rescuerun/views/ambulance/sendnotification.dart';
import 'package:rescuerun/views/ambulance/sendpatient.dart';
import 'package:rescuerun/views/ambulance/viewallbookingambulance.dart';
import 'package:rescuerun/views/ambulance/viewallipbookings.dart';
import 'package:rescuerun/views/hospital/hospital_homepage.dart';
import 'package:rescuerun/views/hospital/trackambulances.dart';
import 'package:rescuerun/views/hospital/viewallambulances.dart';
import 'package:rescuerun/views/hospital/viewallbookinghospip.dart';
import 'package:rescuerun/views/hospital/viewallfeedbackambulance.dart';
import 'package:rescuerun/views/users/bookambulanceip.dart';
import 'package:rescuerun/views/users/hospitaldetails.dart';
import 'package:rescuerun/views/users/user_homepage.dart';
import 'package:rescuerun/views/users/usermapscreen.dart';

import 'common/splash_page.dart';
import 'constant/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HospitalRegistrationController()),
        ChangeNotifierProvider(
            create: (_) => AmbulanceRegistrationController()),
      ],
      child: const RescueRun(),
    ),
  );
}

class RescueRun extends StatelessWidget {
  const RescueRun({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RescueRun",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade100,
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'firebase_options.dart';

// import 'package:rescuerun/screens/admin/adminhomepage.dart';
// import 'package:rescuerun/screens/admin/hospitalregistration.dart';
// import 'package:rescuerun/screens/ambulance/ambulance_homepage.dart';
// import 'package:rescuerun/screens/ambulance/ambulance_registration.dart';
// import 'package:rescuerun/screens/ambulance/location.dart';
// import 'package:rescuerun/screens/ambulance/sendemergencymessage.dart';
// import 'package:rescuerun/screens/ambulance/sendnotification.dart';
// import 'package:rescuerun/screens/ambulance/sendpatient.dart';
// import 'package:rescuerun/screens/ambulance/viewallbookingambulance.dart';
// import 'package:rescuerun/screens/ambulance/viewallipbookings.dart';
// import 'package:rescuerun/screens/hospital/hospital_homepage.dart';
// import 'package:rescuerun/screens/hospital/trackambulances.dart';
// import 'package:rescuerun/screens/hospital/viewallambulances.dart';
// import 'package:rescuerun/screens/hospital/viewallbookinghospip.dart';
// import 'package:rescuerun/screens/hospital/viewallfeedbackambulance.dart';
// import 'package:rescuerun/screens/users/bookambulanceip.dart';
// import 'package:rescuerun/screens/users/hospitaldetails.dart';
// import 'package:rescuerun/screens/users/user_homepage.dart';
// import 'package:rescuerun/screens/users/usermapscreen.dart';

// import 'common/splash_page.dart';
// import 'constant/colors.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // ✅ Use Firebase.initializeApp with options
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const RescueRun());
// }

// class RescueRun extends StatelessWidget {
//   const RescueRun({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "RescueRun",
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.green.shade100,
//         useMaterial3: true,
//       ),
//       home: SplashPage(),
//     );
//   }
// }
