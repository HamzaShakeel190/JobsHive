class UserModel {
  String? id;
  String? name;
  String? email;
  String? profilePicture;
  DateTime? created;
  String? plan;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.created,
    this.plan,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'created': created?.toIso8601String(),
      'plan': plan,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      plan: json['plan'],
    );
  }
}

/*
The id of the current user is: XAvGiAtahgU1BnK6KarapcZdv3K2
The name of the current user is: Panther Gaming
The email of the current user is: panthergaming424@gmail.com
The profile picture of the current user is: https://lh3.googleusercontent.com/a/ACg8ocKM2m-Rtb_oS2MkN6iVB82CsW9h40EblEWGwbYHIqCUSLY=s96-c
The created date of the current user is: 2024-01-25T13:03:37.897543
The isPaid of the current user is: false
The havePreviousYearPlan of the current user is: false
The trialStart of the current user is: 2024-01-25T13:03:37.897546
The trialEnd of the current user is: 2024-02-25T13:03:00.000
The subscriptionHistory of the current user is: []
The shareCount of the current user is: 0
*/
