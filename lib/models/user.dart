class UserModel {
  
  String? uid;
  String? name;
  String? email;
  String? id;
  String? photoUrl;
  String? phone;
  String? role;
  bool? verified;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.id,
    this.photoUrl,
    this.phone,
    this.role,
    this.verified,
  });

  // getting from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      id: map['id'],
      photoUrl: map['photoUrl'],
      phone: map['phone'],
      role: map['role'],
      verified: map['verified'],
    );
  }

  // sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
      'phone': phone,
      'role': role,
      'verified': verified,
    };
  }

  // implementing setters and getters
  String get getUid => uid!;
  set setUid(String value) => uid = value;

  String get getName => name!;
  set setName(String value) => name = value;

  String get getEmail => email!;
  set setEmail(String value) => email = value;

  String get getId => id!;
  set setId(String value) => id = value;

  String get getPhotoUrl => photoUrl!;
  set setPhotoUrl(String value) => photoUrl = value;

  String get getPhone => phone!;
  set setPhone(String value) => phone = value;

  String get getRole => role!;
  set setRole(String value) => role = value;

  bool get getVerified => verified!;
  set setVerified(bool value) => verified = value;

}