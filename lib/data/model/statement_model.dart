class SatatementModel {
  String? date;
  String? remark;
  String? fromto;
  String? pts;
  String? marketid;
  double? credit;
  double? debit;
  int? sno;

  SatatementModel(
      {this.date,
      this.remark,
      this.fromto,
      this.pts,
      this.marketid,
      this.credit,
      this.debit,
      this.sno});

  SatatementModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    remark = json['remark'];
    fromto = json['fromto'];
    pts = json['pts'];
    marketid = json['marketid'] ?? "";
    credit = json['credit'];
    debit = json['debit'];
    sno = json['sno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['remark'] = remark;
    data['fromto'] = fromto;
    data['pts'] = pts;
    data['marketid'] = marketid;
    data['credit'] = credit;
    data['debit'] = debit;
    data['sno'] = sno;
    return data;
  }
}
