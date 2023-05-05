import 'package:firebase_database/firebase_database.dart';

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

  void readUser() async {
    final DatabaseReference ref = await FirebaseDatabase.instance.ref();
    await ref.child('users/1').onValue.listen((event) {
      dynamic values = event.snapshot.value;
      print(values);
    });
  }
}
