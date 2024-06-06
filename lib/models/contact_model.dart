class Contact {
  int? id;
  String name;
  String phone;
  String? image;

  Contact({this.id, required this.name, required this.phone, this.image});

  Map<String, dynamic> toJson() {
    final json = {'name': name, 'phone': phone, 'image': image};

    if (id != null) {
      json['id'] = id as String?;
    }
    return json;
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}

// class Contact {
//   int? id;
//   String name;
//   String phone;
//   String? imagePath;
//
//   Contact({this.id, required this.name, required this.phone, this.imagePath});
//
//   Map<String, dynamic> toMap() {
//     final map = <String, dynamic>{
//       'name': name,
//       'phone': phone,
//       'imagePath': imagePath,
//     };
//     if (id != null) {
//       map['id'] = id;
//     }
//     return map;
//   }
//
//   factory Contact.fromMap(Map<String, dynamic> map) {
//     return Contact(
//       id: map['id'],
//       name: map['name'],
//       phone: map['phone'],
//       imagePath: map['imagePath'],
//     );
//   }
// }
