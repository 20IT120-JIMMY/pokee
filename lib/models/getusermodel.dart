class GetUserModel {
  String? id;
  String? displayName;
  String? userName;
  String? phoneNumber;

  GetUserModel({this.id, this.displayName, this.userName, this.phoneNumber});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_name'] = this.displayName;
    data['user_name'] = this.userName;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
