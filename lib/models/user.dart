import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:culture_trip/models/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Users {
  int? id;
  String? nama;
  String? email;
  String? bio;
  String? alamat;
  String? ttl;
  String? password;

  Users({
    this.id,
    this.nama,
    this.alamat,
    this.bio,
    this.email,
    this.password,
    this.ttl,
  });

// favorite paket
  upFavorite(id, data) async {
    await FirebaseHelper.ref.child('Paket/${id}').update({
      "favorite": data,
    });
  }

  // ganti foto

  Future<String> addFoto(file, namaFolder, context) async {
    DateTime now = DateTime.now();
    final fileUpload = FbStorage.storage.child('${namaFolder}/${namaFolder}-${now}').putFile(file);
    final snapshot = await fileUpload.whenComplete(() {});
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    if (downloadUrl != null) {
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

  upLokasi(latitude, longitude) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    await FirebaseHelper.ref.child('users/${key}').update({
      "lokasi": {
        "latitude": latitude,
        "longitude": longitude
      },
    });
  }

// function increment id
  Future<String> numCount() async {
    final completer = Completer<String>();

    FirebaseHelper.ref.child('users/counter').onValue.listen((event) {
      final counter = event.snapshot.value.toString();
      if (!completer.isCompleted) {
        completer.complete(counter);
      }
    });

    return completer.future;
  }

// update nilai increment
  upCount(newNumCount) async {
    await FirebaseHelper.ref.child('users').update({
      "counter": newNumCount,
    });
  }

// crud akun

// read akun semuanya
  Future readUser() async {
    // untuk melihat data users
    await FirebaseHelper.ref.child('users').onValue.listen((event) {
      dynamic values = event.snapshot.value;
    });
  }

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
  upUser() async {
    numCount().then(
      (value) async {
        int count = int.parse(value) + 1;
        await FirebaseHelper.ref.child('users').set({
          '${count}': {
            "id": count,
            "nama": nama,
            "alamat": alamat,
            "email": email,
            "password": password,
            "bio": 'belum diisi',
            "ttl": 'belum diisi',
          }
        });

        await upCount(count);
      },
    );
  }

  // menambah data user
  Future<bool> addUser() async {
    final user = await FirebaseHelper.ref.child('users/${nama}').get();

    if (user.exists) {
      return false;
    }

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );

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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);

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
