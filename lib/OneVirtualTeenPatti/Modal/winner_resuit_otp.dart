class WinnerResultOPT {
  String? mid;
  String? c1;
  String? winner;
  String? detail;

  WinnerResultOPT({this.mid, this.c1, this.winner, this.detail});

  WinnerResultOPT.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    c1 = json['C1'];
    winner = json['winner'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['C1'] = this.c1;
    data['winner'] = this.winner;
    data['detail'] = this.detail;
    return data;
  }
}
