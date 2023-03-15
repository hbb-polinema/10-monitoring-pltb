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
    String? nama,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
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
    String? clusterId,
    String? nama,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(clusterId);
    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Data cluster berhasil diupdate"))
        .catchError((e) => print(e));
  }

  // hapus cluster
  Future<void> deleteCluster({
    String? docId,
    String? nama,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(docId);
    await docReferencer
        .delete()
        .whenComplete(() => print('Data cluster berhasil dihapus'))
        .catchError((e) => print(e));
  }

// PERANGKAT
  // menambahkan perangkat
  Future<void> addPerangkat({
    String? kodePerangkat,
    String? jenisPerangkat,
    String? cluster,
  }) async {
    DocumentReference docReferencer = perangkatCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "kodePerangkat": kodePerangkat,
      "jenisPerangkat": jenisPerangkat,
      "cluster": cluster
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
    return perangkatCollection.where('jenis', isEqualTo: 'Batery').snapshots();
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
