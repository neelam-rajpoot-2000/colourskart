class LiablityModel {
  LiablityModel({
    required this.sid,
    required this.liability,
  });
  late final String sid;
  late final double liability;

  LiablityModel.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    liability = json['liability'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sid'] = sid;
    data['liability'] = liability;
    return data;
  }
}
