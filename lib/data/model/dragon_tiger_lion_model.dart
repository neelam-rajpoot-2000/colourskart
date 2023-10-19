// ignore_for_file: non_constant_identifier_names

class DragonTigerLionResult {
  DragonTigerLionResult({
    required this.mid,
    required this.card1,
    required this.card2,
    required this.card3,
    required this.winner,
    required this.winnerDetail,
    required this.dragonDetail,
    required this.tigerDetail,
    required this.lionDetail,
  });
  late final String mid;
  late final String card1;
  late final String card2;
  late final String card3;
  late final String winner;
  late final String winnerDetail;
  late final String dragonDetail;
  late final String tigerDetail;
  late final String lionDetail;

  DragonTigerLionResult.fromJson(Map<String, dynamic> json) {
    mid = json['mid'].toString();
    card1 = json['C1'].toString();
    card2 = json['C2'].toString();
    card3 = json['C3'].toString();
    winner = json['winner'];
    winnerDetail = json['winnerDetail'].toString();
    dragonDetail = json['dragonDetail'].toString();
    tigerDetail = json['tigerDetail'].toString();
    lionDetail = json['lionDetail'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mid'] = mid;
    data['C1'] = card1;
    data['C2'] = card2;
    data['C3'] = card3;
    data['winner'] = winner;
    data['winnerDetail'] = winnerDetail;
    data['dragonDetail'] = dragonDetail;
    data['tigerDetail'] = tigerDetail;
    data['lionDetail'] = lionDetail;
    return data;
  }
}

class BollyWoodResultModel {
  String? mid;
  String? c1;
  String? winner;
  String? detail;

  BollyWoodResultModel({this.mid, this.c1, this.winner, this.detail});

  BollyWoodResultModel.fromJson(Map<String, dynamic> json) {
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
