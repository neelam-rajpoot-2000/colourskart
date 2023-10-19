class WinnerResult {
  String? mid;
  String? c1;
  String? winner;
  String? detail;

  WinnerResult({this.mid, this.c1, this.winner, this.detail});

  WinnerResult.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    c1 = json['C1'];
    winner = json['winner'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mid'] = mid;
    data['C1'] = c1;
    data['winner'] = winner;
    data['detail'] = detail;
    return data;
  }
}
