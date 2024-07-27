class Users {
  final String id;
  final String name;
  final String email;
  final String contact;
  final String password;
  final String address;
  final bool isAdmin;
  final bool isOpen;

  const Users({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.password,
    required this.address,
    this.isAdmin = false,
    this.isOpen = true,
  });

  // Convert a Users object into a map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'password': password,
      'address': address,
      'isAdmin': isAdmin,
      'isOpen': isOpen,
    };
  }

  // Convert a map into a Users object
  static Users fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      password: json['password'],
      address: json['address'],
      isAdmin: json['isAdmin'],
      isOpen: json['isOpen'],
    );
  }
}
