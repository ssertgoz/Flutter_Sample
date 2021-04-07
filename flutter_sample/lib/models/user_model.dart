class UserModel {
  String uid;
  String email;
  String displayName;
  String phoneNumber;
  String photoUrl;
  String name;
  String surName;
  String gender;
  String birthDay;
  String weight;
  String height;
  String motivation;

  UserModel(
      {this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.name,
      this.surName,
      this.gender,
      this.birthDay,
      this.weight,
      this.height,
      this.motivation});

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String uid = data['uid'];
    String email = data['email'];
    String displayName = data['displayName'];
    String phoneNumber = data['phoneNumber'];
    String photoUrl = data['photoUrl'];
    String name = data['name'];
    String surName = data['surName'];
    String gender = data['gender'];
    String birthDay = data['birthDay'];
    String weight = data['weight'];
    String height = data['height'];
    String motivation = data['motivation'];

    return UserModel(
        uid: uid,
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        name: name,
        surName: surName,
        gender: gender,
        birthDay: birthDay,
        weight: weight,
        height: height,
        motivation: motivation);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      "displayName": this.displayName,
      "phoneNumber": this.phoneNumber,
      "photoUrl": this.photoUrl,
      "name": this.name,
      "surName": this.surName,
      "gender": this.gender,
      "birthDay": this.birthDay,
      "weight": this.weight,
      "height": this.height,
      "motivation": this.motivation
    };
  }
}
