class GameListModel {
  int? gameId;
  String? gameCode;
  String? gameName;
  String? imageUrl;

  GameListModel({this.gameId, this.gameCode, this.gameName, this.imageUrl});

  GameListModel.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    gameCode = json['gameCode'];
    gameName = json['gameName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gameId'] = gameId;
    data['gameCode'] = gameCode;
    data['gameName'] = gameName;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
