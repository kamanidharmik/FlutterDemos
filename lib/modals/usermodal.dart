class UserModal {
  String gender;
  String name;

  UserModal({required this.gender, required this.name});

  factory UserModal.fromJson(Map<String, dynamic> parsedJson) {
    return UserModal(
      gender: parsedJson['gender'].toString(),
      name: parsedJson['name'].toString(),
    );
  }
}
