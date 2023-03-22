import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference clusterCollection =
      FirebaseFirestore.instance.collection('cluster');
  final CollectionReference perangkatCollection =
      FirebaseFirestore.instance.collection('perangkat');
  final CollectionReference asetCollection =
      FirebaseFirestore.instance.collection('aset');
  final CollectionReference pengecekanCollection =
      FirebaseFirestore.instance.collection('pengecekan');
  final CollectionReference perbaikanCollection =
      FirebaseFirestore.instance.collection('perbaikan');
  final CollectionReference perawatanCollection =
      FirebaseFirestore.instance.collection('perawatan');

// USER
  // menambahkan user
  Future<void> addUser({
    String? email,
    String? nama,
    String? role,
    String? noHp,
  }) async {
    if (email!.isNotEmpty && nama!.isNotEmpty) {
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: "12345678");
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await firestore.collection("user").doc(uid).set({
            "nama": nama,
            "email": email,
            "uid": uid,
            "noHp": noHp,
            "role": role,
            "createdAt": DateTime.now().toIso8601String()
          });
        }
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          const SnackBar(
              content: Text("Password yang digunakan terlalu singkat"));
        } else if (e.code == 'email-already-in-use') {
          const SnackBar(content: Text("User telah terdaftar"));
        }
      } catch (e) {
        const SnackBar(content: Text("Tidak dapat menambahkan user"));
      }
    } else {
      const SnackBar(content: Text("Email dan nama harus terisi"));
    }
  }

  // menampilkan list user
  Stream<QuerySnapshot> listUser() {
    return userCollection.orderBy('nama').snapshots();
  }

  // user role
  Stream<DocumentSnapshot<Map<String, dynamic>>> userRole() async* {
    String? uid = auth.currentUser?.uid;
    yield* firestore.collection("user").doc(uid).snapshots();
  }

// CLUSTER
  // menambahkan cluster
  Future<void> addCluster({
    String? id,
    String? nama,
    required double lat,
    required double lng,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "nama": nama,
      "lokasi": GeoPoint(lat, lng)
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data cluster berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list cluster
  Stream<QuerySnapshot> listCluster() {
    return clusterCollection.snapshots();
  }

  // edit cluster
  Future<void> updateCluster({
    String? documentId,
    String? id,
    String? nama,
    required double lat,
    required double lng,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(documentId);
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "nama": nama,
      "lokasi": GeoPoint(lat, lng)
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Data cluster berhasil diupdate"))
        .catchError((e) => print(e));
  }

  // hapus cluster
  Future<void> deleteCluster({
    String? documentId,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(documentId);
    await docReferencer
        .delete()
        .whenComplete(() => print('Data cluster berhasil dihapus'))
        .catchError((e) => print(e));
  }

// PERANGKAT
  // menambahkan perangkat
  Future<void> addPerangkat({
    String? documentId,
    String? idPerangkat,
    String? kodePerangkat,
    String? jenisPerangkat,
    String? statusPerangkat,
  }) async {
    DocumentReference docReferencer =
        clusterCollection.doc(documentId).collection('perangkat').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "id": idPerangkat,
      "kode": kodePerangkat,
      "jenis": jenisPerangkat,
      "status": statusPerangkat
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data perangkat berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list perangkat
  Stream<QuerySnapshot> listPerangkat(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.snapshots();
  }

  // menampilkan list perangkat pltb
  Stream<QuerySnapshot> listPerangkatWT(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'PLTB').snapshots();
  }

  // menampilkan list perangkat plts
  Stream<QuerySnapshot> listPerangkatSP(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'PLTS').snapshots();
  }

  // menampilkan list perangkat diesel
  Stream<QuerySnapshot> listPerangkatDS(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'Diesel').snapshots();
  }

  // menampilkan list perangkat batery
  Stream<QuerySnapshot> listPerangkatBT(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'Baterai').snapshots();
  }

  // menampilkan list perangkat weather station
  Stream<QuerySnapshot> listPerangkatWS(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection
        .where('jenis', isEqualTo: 'Weather Station')
        .snapshots();
  }

  // menampilkan list perangkat rumah energi
  Stream<QuerySnapshot> listPerangkatRE(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection
        .where('jenis', isEqualTo: 'Rumah Energi')
        .snapshots();
  }

  // edit perangkat
  Future<void> updatePerangkat({
    String? docClusterId,
    String? docPerangkatId,
    String? idPerangkat,
    String? kodePerangkat,
    String? jenisPerangkat,
    String? statusPerangkat,
  }) async {
    DocumentReference docReferencer = clusterCollection
        .doc(docClusterId)
        .collection('perangkat')
        .doc(docPerangkatId);
    Map<String, dynamic> data = <String, dynamic>{
      "id": idPerangkat,
      "kode": kodePerangkat,
      "jenis": jenisPerangkat,
      "status": statusPerangkat
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Data cluster berhasil diupdate"))
        .catchError((e) => print(e));
  }

  // hapus perangkat
  Future<void> deletePerangkat({
    String? docPerangkatId,
    String? docClusterId,
  }) async {
    DocumentReference docReferencer = clusterCollection
        .doc(docClusterId)
        .collection('perangkat')
        .doc(docPerangkatId);
    await docReferencer
        .delete()
        .whenComplete(() => print('Data perangkat berhasil dihapus'))
        .catchError((e) => print(e));
  }

// ASSET GUDANG
  // menambahkan asset gudang
  Future<void> addAssetGudang({
    String? documentId,
    // String? kodeAssetGudang,
    String? jenisAset,
    String? spd11,
    String? spd12,
    String? spd13,
    String? spd21,
    String? spd31,
    String? spd41,
    String? spd42,
    String? spd51,
    String? lokasi,
    String? kondisi,
    String? tglDiterima,
  }) async {
    DocumentReference docReferencer =
        clusterCollection.doc(documentId).collection('gudang').doc();
    Map<String, dynamic> data = <String, dynamic>{
      // "kode": kodeAssetGudang,
      "jenis": jenisAset,
      "spd11": spd11,
      "spd12": spd12,
      "spd13": spd13,
      "spd21": spd21,
      "spd31": spd31,
      "spd41": spd41,
      "spd42": spd42,
      "spd51": spd51,
      "lokasi": lokasi,
      "kondisi": kondisi,
      "tglDiterima": tglDiterima,
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data perangkat berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list perangkat mekanik
  Stream<QuerySnapshot> listMekanik(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('gudang');
    return gudangCollection.where('jenis', isEqualTo: 'Mekanik').snapshots();
  }

  // menampilkan list perangkat elektrik
  Stream<QuerySnapshot> listElektrik(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('gudang');
    return gudangCollection.where('jenis', isEqualTo: 'Elektrik').snapshots();
  }

  // menampilkan list perangkat komunikasi data
  Stream<QuerySnapshot> listKd(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('gudang');
    return gudangCollection
        .where('jenis', isEqualTo: 'Komunikasi Data')
        .snapshots();
  }

  // menampilkan list sensor
  Stream<QuerySnapshot> listSensor(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('gudang');
    return gudangCollection.where('jenis', isEqualTo: 'Sensor').snapshots();
  }

  // menampilkan list IT
  Stream<QuerySnapshot> listIt(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('gudang');
    return gudangCollection.where('jenis', isEqualTo: 'IT').snapshots();
  }

  // menampilkan list Sipil
  Stream<QuerySnapshot> listSipil(String idCluster) {
    CollectionReference gudangCollection =
        clusterCollection.doc(idCluster).collection('sipil');
    return gudangCollection.where('jenis', isEqualTo: 'Sipil').snapshots();
  }

// ASET
  // menampilkan list aset
  Stream<QuerySnapshot> listAset(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('aset');
    return asetCollection.snapshots();
  }

  // menampilkan list aset menunggu
  Stream<QuerySnapshot> listAsetMenunggu() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Menunggu')
        .snapshots();
  }

  // menampilkan list aset diterima
  Stream<QuerySnapshot> listAsetDiterima() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Diterima')
        .snapshots();
  }

  // menampilkan list aset ditolak
  Stream<QuerySnapshot> listAsetDitolak() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Ditolak')
        .snapshots();
  }

  // konfirmasi aset
  Future<void> konfirmasiAset({
    String? asetId,
    String? statusKonfirmasi,
  }) async {
    DocumentReference docReferencer = asetCollection.doc(asetId);
    Map<String, dynamic> data = <String, dynamic>{
      "statusKonfirmasi": statusKonfirmasi,
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Konfirmasi berhasil"))
        .catchError((e) => print(e));
  }

// // PENGECEKAN
  // menampilkan list pengecekan
  Stream<QuerySnapshot> listPengecekan() {
    return pengecekanCollection.snapshots();
  }

//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

// PERBAIKAN
  // menampilkan list perbaikan
  Stream<QuerySnapshot> listPerbaikan() {
    return perbaikanCollection.snapshots();
  }
//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

// PERAWATAN
  // menampilkan list perawatan
  Stream<QuerySnapshot> listPerawatan() {
    return perawatanCollection.snapshots();
  }
//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

}
