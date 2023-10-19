class CurrentBetsModel {
  String? eventName;
  String? username;
  String? marketname;
  String? nation;
  String? time;
  String? sportName;
  int? amount;
  int? sportId;
  String? rate;
  String? deviceInfo;
  bool? isback;
  String? eventType;
  String? price;
  double? pnl;
  int? matchId;

  CurrentBetsModel(
      {this.eventName,
      this.username,
      this.marketname,
      this.nation,
      this.time,
      this.sportName,
      this.amount,
      this.sportId,
      this.rate,
      this.deviceInfo,
      this.isback,
      this.eventType,
      this.price,
      this.pnl,
      this.matchId});

  CurrentBetsModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    username = json['username'];
    marketname = json['marketname'];
    nation = json['nation'];
    time = json['time'];
    sportName = json['sportName'];
    amount = json['amount'];
    sportId = json['sportId'];
    rate = json['rate'];
    deviceInfo = json['deviceInfo'];
    isback = json['isback'];
    eventType = json['eventType'];
    price = json['price'];
    pnl = json['pnl'];
    matchId = json['matchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['username'] = username;
    data['marketname'] = marketname;
    data['nation'] = nation;
    data['time'] = time;
    data['sportName'] = sportName;
    data['amount'] = amount;
    data['sportId'] = sportId;
    data['rate'] = rate;
    data['deviceInfo'] = deviceInfo;
    data['isback'] = isback;
    data['eventType'] = eventType;
    data['price'] = price;
    data['pnl'] = pnl;
    data['matchId'] = matchId;
    return data;
  }
}
