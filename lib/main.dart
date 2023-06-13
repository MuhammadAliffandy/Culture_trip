import 'package:culture_trip/pages/Home%20Screen/berandaScreen.dart';
import 'package:culture_trip/pages/Budaya%20Screen/budayaScreen.dart';
import 'package:culture_trip/pages/Home%20Screen/homeScreen.dart';
import 'package:culture_trip/pages/Informasi%20Screen/informasiScreen.dart';
import 'package:culture_trip/pages/Informasi%20Screen/readInfo.dart';
import 'package:culture_trip/pages/Paket%20Screen/favoritePaket.dart';
import 'package:culture_trip/pages/Paket%20Screen/readPaket.dart';
import 'package:culture_trip/pages/PesananScreen/pesananScreen.dart';
import 'package:culture_trip/pages/PesananScreen/readPesanan.dart';
import 'package:culture_trip/pages/TripScreen/tripScreen.dart';
import 'package:culture_trip/pages/loginScreen.dart';
import 'package:culture_trip/pages/Paket%20Screen/paketScreen.dart';
import 'package:culture_trip/pages/profilScreen.dart';
import 'package:culture_trip/pages/readItem.dart';
import 'package:culture_trip/pages/regisScreen.dart';
import 'package:culture_trip/pages/Wisata%20Screen/wisataScreen.dart';
import 'package:culture_trip/pages/showMap.dart';
import 'package:culture_trip/pages/ShowMapProfil.dart';
import 'package:culture_trip/widgets/loadUpdate.dart';
import 'package:culture_trip/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(CultureTrip());
}

class CultureTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color warnaUtama = Color.fromARGB(255, 234, 105, 105);
    Color warnaBg = Color.fromARGB(255, 239, 238, 238);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: warnaUtama,
        backgroundColor: warnaBg,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
          ),
        ),
      ),
      routes: {
        "/regis": (context) => RegisScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/beranda': (context) => BerandaScreen(),
        '/paket': (context) => PaketScreen(),
        '/wisata': (context) => WisataScreen(),
        '/budaya': (context) => BudayaScreen(),
        '/informasi': (context) => InformasiScreen(),
        '/profil': (context) => ProfileScreen(),
        '/trip': (context) => TripScreen(),
        '/favorit': (context) => FavoriteScreen(),
        '/pesanan': (context) => PesananScreen(),
        '/readItem': (context) => ReadItemScreen(),
        '/readInfo': (context) => ReadInformasiScreen(),
        '/readPaket': (context) => ReadPaketScreen(),
        '/readPesanan': (context) => ReadPesananScreen(),
        '/showMapProfil': (context) => MapSample(),
        '/showMap': (context) => ShowMapScreen(),
        '/loadUp': (context) => LoadingUpdate(),
      },
      home: MySplashScreen(),
    );
  }
}
