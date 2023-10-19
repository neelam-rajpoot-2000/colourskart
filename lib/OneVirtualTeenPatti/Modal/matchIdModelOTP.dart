class MatchIdModelOPT {
  String? nation;
  double? rate;
  int? amount;
  double? priveValue;
  String? marketName;
  String? betTime;
double? pnl;
  bool? back;

  MatchIdModelOPT(
      {this.nation,
      this.rate,
      this.amount,
      this.priveValue,
      this.marketName,
      this.betTime,
      this.pnl,
      this.back});

  MatchIdModelOPT.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nation'] = this.nation;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['priveValue'] = this.priveValue;
    data['marketName'] = this.marketName;
    data['betTime'] = this.betTime;
    data['pnl'] = this.pnl;
    data['back'] = this.back;
    return data;
  }
}
