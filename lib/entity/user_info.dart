class UserInfo {
  String accessToken;
  String displayName;

  UserInfo({
    this.accessToken,
    this.displayName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        accessToken: json["access_token"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
      };
}
