class DTResultModel {
  String? mid;
  String? c1;
  String? c2;
  String? winner;
  String? dragonDetail;
  String? tigerDetail;
  String? winnerDetail;

  DTResultModel(
      {this.mid,
      this.c1,
      this.c2,
      this.winner,
      this.dragonDetail,
      this.tigerDetail,
      this.winnerDetail});

  DTResultModel.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    c1 = json['C1'];
    c2 = json['C2'];
    winner = json['winner'];
    dragonDetail = json['dragonDetail'];
    tigerDetail = json['tigerDetail'];
    winnerDetail = json['winnerDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['C1'] = this.c1;
    data['C2'] = this.c2;
    data['winner'] = this.winner;
    data['dragonDetail'] = this.dragonDetail;
    data['tigerDetail'] = this.tigerDetail;
    data['winnerDetail'] = this.winnerDetail;
    return data;
  }
}
