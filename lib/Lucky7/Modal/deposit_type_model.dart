class DepositTypeModel {
  String? id;
  String? depositType;
  String? image;
  int? appid;
  bool? adminActive;
  String? bankName;
  String? accountNumber;
  String? accountType;
  String? accountHolderName;
  String? ifsc;
  bool? active;

  DepositTypeModel(
      {this.id,
      this.depositType,
      this.image,
      this.appid,
      this.adminActive,
      this.bankName,
      this.accountNumber,
      this.accountType,
      this.accountHolderName,
      this.ifsc,
      this.active});

  DepositTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    depositType = json['depositType'];
    image = json['image'];
    appid = json['appid'];
    adminActive = json['adminActive'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    accountHolderName = json['accountHolderName'];
    ifsc = json['ifsc'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['depositType'] = depositType;
    data['image'] = image;
    data['appid'] = appid;
    data['adminActive'] = adminActive;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['accountType'] = accountType;
    data['accountHolderName'] = accountHolderName;
    data['ifsc'] = ifsc;
    data['active'] = active;
    return data;
  }
}
