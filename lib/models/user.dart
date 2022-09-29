class UserModel {
  String uid;
  String name;
  String email;
  String id;
  String imageUrl;
  String phone;
  String role;
  bool verified;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.id,
    this.imageUrl = 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    required this.phone,
    required this.role,
    required this.verified,
  });

  // getting from server
  static UserModel fromJson(Map<String, dynamic> data) => UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        id: data['id'],
        imageUrl: data['imageUrl'],
        phone: data['phone'],
        role: data['role'],
        verified: data['verified'],
      );

  // sending to server
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'id': id,
        'imageUrl': imageUrl,
        'phone': phone,
        'role': role,
        'verified': verified,
      };
}
