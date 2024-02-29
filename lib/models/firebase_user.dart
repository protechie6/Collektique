import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String uid;

  FirebaseUser(this.uid);

  factory FirebaseUser.initialData() {
    return FirebaseUser("");
  }
}

class UserData {
  final String username;
  final String search;
  final String email;
  final String id;
  final String dp;
  final String accountType;
  final String accountSub;
  final List<String> libraryCollections;
  final String pin;
  final List<List<String>> transactionRecords;
  final Map<String, dynamic> insuranceDetail;

  UserData({
    required this.username,
    required this.search,
    required this.email,
    required this.id,
    required this.dp,
    required this.accountType,
    required this.accountSub,
    required this.libraryCollections,
    required this.pin,
    required this.transactionRecords,
    required this.insuranceDetail,
  });

  factory UserData.initialData() {
    return UserData(
        accountSub: '',
        accountType: '',
        dp: '',
        email: '',
        username: '',
        search:'',
        id: '',
        libraryCollections: [],
        pin: '',
        transactionRecords: [],
        insuranceDetail: {});
  }

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      username: data?['username'],
      search: data?['search'],
      email: data?['email'],
      id: data?['id'],
      dp: data?['dp'],
      accountType: data?['accountType'],
      accountSub: data?['accountSub'],
      libraryCollections: List.from(data?['libraryCollections']),
      pin: data?['pin'],
      transactionRecords: List.from(data?['transactionRecords']),
      insuranceDetail: data?['insuranceDetail'],
    );
  }

  factory UserData.fromDocument(DocumentSnapshot documentSnapshot) {
    String username = documentSnapshot.get("username");
    String search = documentSnapshot.get("search");
    String email = documentSnapshot.get("email");
    String id = documentSnapshot.get("id");
    String dp = documentSnapshot.get("dp");
    String accountType = documentSnapshot.get("accountType");
    String accountSub = documentSnapshot.get("accountSub");
    List<String> libraryCollections =
        documentSnapshot.get("libraryCollections").cast<String>();
    String pin = documentSnapshot.get("pin");
    List<List<String>> transactionRecords =
        documentSnapshot.get("transactionRecords").cast<List<String>>();
    Map<String, dynamic> insuranceDetail =
        documentSnapshot.get('insuranceDetail');
    return UserData(
      username: username,
      search: search,
      email: email,
      id: id,
      dp: dp,
      accountType: accountType,
      accountSub: accountSub,
      libraryCollections: libraryCollections,
      pin: pin,
      transactionRecords: transactionRecords,
      insuranceDetail: insuranceDetail,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "search": search,
      "email": email,
      "id": id,
      "dp": dp,
      "accountType": accountType,
      "accountSub": accountSub,
      "libraryCollections": libraryCollections,
      "pin": pin,
      "transactionRecords": transactionRecords,
      "insuranceDetail": insuranceDetail,
    };
  }
}

class InsuranceDetail {
  String insuranceCompany;
  String policyNumber;
  String email;
  String insuranceNumber;

  InsuranceDetail({
    required this.insuranceCompany,
    required this.policyNumber,
    required this.email,
    required this.insuranceNumber,
  });

  factory InsuranceDetail.fromJson(Map<dynamic, dynamic> data) =>
      InsuranceDetail(
        insuranceCompany: data['insuranceCompany'],
        policyNumber: data['policyNumber'],
        email: data['email'],
        insuranceNumber: data['insuranceNumber'],
      );

  Map<String, dynamic> toJson() {
    return {
      "insuranceCompany": insuranceCompany,
      "policyNumber": policyNumber,
      "email": email,
      "insuranceNumber": insuranceNumber,
    };
  }
}
