class ButtonsModelDTL {
  ButtonsModelDTL({
    required this.mid,
    required this.nat,
    required this.rate,
    required this.min,
    required this.max,
    required this.gstatus,
    required this.sid,
  });
  late final String mid;
  late final String nat;
  late final String rate;
  late final String min;
  late final String max;
  late final String gstatus;
  late final String sid;

  ButtonsModelDTL.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    nat = json['nat'];
    rate = json['rate'];
    min = json['min'];
    max = json['max'];
    gstatus = json['gstatus'];
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mid'] = mid;
    data['nat'] = nat;
    data['rate'] = rate;
    data['min'] = min;
    data['max'] = max;
    data['gstatus'] = gstatus;
    data['sid'] = sid;
    return data;
  }
}

class ButtonsModelBollyWood {
  String? mid;
  String? nat;
  String? rate;
  String? layrate;
  String? min;
  String? max;
  String? gstatus;
  String? sid;

  ButtonsModelBollyWood(
      {this.mid,
      this.nat,
      this.rate,
      this.layrate,
      this.min,
      this.max,
      this.gstatus,
      this.sid});

  ButtonsModelBollyWood.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    nat = json['nat'];
    rate = json['rate'];
    layrate = json['layrate'];
    min = json['min'];
    max = json['max'];
    gstatus = json['gstatus'];
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['nat'] = this.nat;
    data['rate'] = this.rate;
    data['layrate'] = this.layrate;
    data['min'] = this.min;
    data['max'] = this.max;
    data['gstatus'] = this.gstatus;
    data['sid'] = this.sid;
    return data;
  }
}
