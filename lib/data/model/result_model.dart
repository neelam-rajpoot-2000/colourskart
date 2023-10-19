class ResultsModel {
  String? mid;
  String? c1;
  String? c2;
  String? c3;
  String? c4;
  String? c5;
  String? c6;
  String? winner;

  ResultsModel(
      {this.mid,
      this.c1,
      this.c2,
      this.c3,
      this.c4,
      this.c5,
      this.c6,
      this.winner});

  ResultsModel.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    c1 = json['C1'];
    c2 = json['C2'];
    c3 = json['C3'];
    c4 = json['C4'];
    c5 = json['C5'];
    c6 = json['C6'];
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mid'] = mid;
    data['C1'] = c1;
    data['C2'] = c2;
    data['C3'] = c3;
    data['C4'] = c4;
    data['C5'] = c5;
    data['C6'] = c6;
    data['winner'] = winner;
    return data;
  }
}
