import 'dart:async';
import 'dart:convert';
import 'package:culture_trip/models/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

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

  Future<String> numCount() async {
    final completer = Completer<String>();

    FirebaseHelper.ref.child('users/counter').onValue.listen((event) {
      final counter = event.snapshot.value.toString();
      completer.complete(counter);
    });

    return completer.future;
  }

  upCount(newNumCount) async {
    await FirebaseHelper.ref.child('users').update({
      "counter": newNumCount,
    });
  }

// crud akun

  Future readUser() async {
    // untuk melihat data users
    await FirebaseHelper.ref.child('users').onValue.listen((event) {
      dynamic values = event.snapshot.value;
    });
  }

  Future<bool?> readUserWithKey(key) async {
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

  upUser() async {
    // update data user
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
            "foto": 'belum diisi',
          }
        });

        await upCount(count);
      },
    );
  }

  Future<bool> addUser() async {
    // menambah data user

    final completer = Completer<bool>();

    readUserWithKey(nama).then((value) => {
          if (value == false)
            {
              numCount().then((value) async {
                int count = int.parse(value) + 1;

                await FirebaseHelper.ref.child('users').child(nama.toString()).set({
                  "id": count,
                  "nama": nama,
                  "alamat": alamat,
                  "email": email,
                  "password": password,
                  "bio": 'belum diisi',
                  "ttl": 'belum diisi',
                  "foto": 'belum diisi',
                });

                await upCount(count);
                completer.complete(true);
              })
            }
          else
            {
              completer.complete(false)
            }
        });
    return completer.future;
  }

  userData(user) {
    final Map<String, dynamic> toMapDynamic = Map<String, dynamic>.from(user);
    final String jsonString = jsonEncode(toMapDynamic);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    var key = jsonData.keys.first.toString();

    return key;
  }

  Future<Map<String, dynamic>> readUserId(key) async {
    var user = await FirebaseHelper.ref.child('users/${key}').once();
    final String jsonString = jsonEncode(user.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> checkUsers(String email, String pass) {
    //login validation
    final completer = Completer<Map<String, dynamic>>();

    FirebaseHelper.ref.child('users').orderByChild('email').equalTo(email).once().then(
      (user) {
        if (user.snapshot.exists) {
          FirebaseHelper.ref.child('users').orderByChild('password').equalTo(pass).once().then(
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
                completer.complete({
                  'status': false,
                  'msg': 'password anda salah',
                });
                print('salah');
              }
            },
          );
        } else {
          completer.complete({
            'status': false,
            'msg': 'email anda salah',
          });
        }
      },
    );
    return completer.future;
  }
  //batas =====================================
}
