import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  MyApp({Key? key}) : super(key: key);
  Stream<User?> get streamAuthStatus => auth.authStateChanges();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              theme: ThemeData(
                useMaterial3: true,
                textTheme: GoogleFonts.nunitoTextTheme(),
              ),
              debugShowCheckedModeBanner: false,
              title: "Application",
              // home: ProductAdd(),
              initialRoute: Routes.HOME,
              getPages: AppPages.routes,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
