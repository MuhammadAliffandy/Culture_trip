import 'dart:async';
import 'dart:convert';
import 'package:culture_trip/models/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users {
  String? nama;
  String? email;
  String? bio;
  String? alamat;
  String? ttl;
  String? password;

  Users({
    this.nama,
    this.alamat,
    this.bio,
    this.email,
    this.password,
    this.ttl,
  });

// favorite paket
  upFavorite(user, paket, isFavorited) async {
    await FirebaseHelper.ref.child('favorit/$user').once().then((value) {
      if (value.snapshot.exists) {
        FirebaseHelper.ref.child('favorit/$user').child('$paket').once().then((value) {
          if (value.snapshot.exists) {
            FirebaseHelper.ref.child('favorit/$user/$paket').update({
              "isFavorited": isFavorited,
            });
          } else {
            FirebaseHelper.ref.child('favorit/$user').child('$paket').set({
              "isFavorited": isFavorited,
              "paket": '$paket',
            });
          }
        });
      } else {
        FirebaseHelper.ref.child('favorit').child('$user').child('$paket').set({
          "isFavorited": isFavorited,
          "paket": '$paket',
        });
      }
    });
  }

  Future<bool> getFavorit(user, paket) async {
    var value = await FirebaseHelper.ref.child('favorit/$user').child('$paket').once();
    if (value.snapshot.exists) {
      var event = await FirebaseHelper.ref.child('favorit/$user/$paket').once();
      Map<String, dynamic> data = await jsonDecode(jsonEncode(event.snapshot.value));
      return data['isFavorited'];
    } else {
      return false;
    }
  }

  Future<bool> showFavorit(user, paket) async {
    var event = await FirebaseHelper.ref.child('favorit/$user/$paket').once();
    Map<String, dynamic> data = await jsonDecode(jsonEncode(event.snapshot.value));

    return data['isFavorited'];
  }

  // ganti foto

  Future<String> addFoto(file, namaFolder, context) async {
    DateTime now = DateTime.now();
    final fileUpload = FbStorage.storage.child('${namaFolder}/${namaFolder}-${now}').putFile(file);
    final snapshot = await fileUpload.whenComplete(() {});
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    if (downloadUrl != false) {
      SharedPreferences session = await SharedPreferences.getInstance();
      String? key = session.getString('user');
      await FirebaseHelper.ref.child('users/${key}').update({
        "foto": downloadUrl
      });
      Navigator.popAndPushNamed(context, '/profil');
    }
    return downloadUrl;
  }

  // update lokasi

  upLokasi(latitude, longitude, newAlamat) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    await FirebaseHelper.ref.child('users/${key}').update({
      "alamat": newAlamat,
      "lokasi": {
        "latitude": latitude,
        "longitude": longitude
      },
    });
  }

// crud akun

// cek user dengan key
  Future<bool> readUserWithKey(key) async {
    final completer = Completer<bool>();
    FirebaseHelper.ref.child('users/${key}').onValue.listen((event) {
      if (event.snapshot.exists) {
        return completer.complete(true);
      } else {
        return completer.complete(false);
      }
    });

    return completer.future;
  }

// update data user
  upUser(key, nama, bio, ttl) async {
    await FirebaseHelper.ref.child('users/${key}').update({
      "nama": nama,
      "bio": bio,
      "ttl": ttl,
    });
  }

  // menambah data user
  Future<bool> addUser() async {
    final user = await FirebaseHelper.ref.child('users/${nama}').get();

    if (user.exists) {
      return false;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
    } catch (e) {
      return false;
    }

    await FirebaseHelper.ref.child('users').child(nama.toString()).set({
      "nama": nama,
      "alamat": alamat,
      "email": email,
      "password": password,
      "bio": 'belum diisi',
      "ttl": 'belum diisi',
      "foto": 'belum diisi',
      "lokasi": {
        "latitude": 0,
        "longitude": 0
      }
    });

    return true;
  }

// compile data object menjadi json dan mengembalikan key
  userData(user) {
    final Map<String, dynamic> toMapDynamic = Map<String, dynamic>.from(user);
    final String jsonString = jsonEncode(toMapDynamic);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    var key = jsonData.keys.first.toString();

    return key;
  }

// read user dengan key dan mengembalikan data user
  Future<Map<String, dynamic>> readUserId(key) async {
    var user = await FirebaseHelper.ref.child('users/${key}').once();
    final String jsonString = jsonEncode(user.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> checkUsers(email, pass) async {
    //login validation
    final completer = Completer<Map<String, dynamic>>();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);

      FirebaseHelper.ref.child('users').orderByChild('email').equalTo(email).once().then(
        (userPass) {
          final Map<dynamic, dynamic>? dbUser = userPass.snapshot.value as Map<dynamic, dynamic>?;
          if (userPass.snapshot.exists) {
            String key = userData(dbUser);
            completer.complete({
              'status': true,
              'msg': 'anda berhasil login',
              'key': '${key}'
            });
          } else {
            print('salah');
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        completer.complete({
          'status': false,
          'msg': 'email anda salah',
        });
      } else if (e.code == 'wrong-password') {
        completer.complete({
          'status': false,
          'msg': 'password anda salah',
        });
      }
    }

    return completer.future;
  }
  //batas =====================================
}
