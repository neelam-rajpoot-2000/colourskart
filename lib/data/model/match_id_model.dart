class MatchIdModel {
  String? nation;
  double? rate;
  int? amount;
  double? priveValue;
  String? marketName;
  String? betTime;
  double? pnl;
  bool? back;

  MatchIdModel(
      {this.nation,
      this.rate,
      this.amount,
      this.priveValue,
      this.marketName,
      this.betTime,
      this.pnl,
      this.back});

  MatchIdModel.fromJson(Map<String, dynamic> json) {
    nation = json['nation'];
    rate = json['rate'];
    amount = json['amount'];
    priveValue = json['priveValue'];
    marketName = json['marketName'];
    betTime = json['betTime'];
    pnl = json['pnl'];
    back = json['back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nation'] = nation;
    data['rate'] = rate;
    data['amount'] = amount;
    data['priveValue'] = priveValue;
    data['marketName'] = marketName;
    data['betTime'] = betTime;
    data['pnl'] = pnl;
    data['back'] = back;
    return data;
  }
}
