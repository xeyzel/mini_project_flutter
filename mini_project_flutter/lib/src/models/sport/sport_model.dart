class SportModel {
  String idSport;
  String strSport;
  String strFormat;
  String strSportThumb;
  String strSportIconGreen;
  String strSportDescription;

  SportModel({
    required this.idSport,
    required this.strSport,
    required this.strFormat,
    required this.strSportThumb,
    required this.strSportIconGreen,
    required this.strSportDescription,
  });

  factory SportModel.fromJson(Map<String, dynamic> json) => SportModel(
        idSport: json["idSport"],
        strSport: json["strSport"],
        strFormat: json["strFormat"],
        strSportThumb: json["strSportThumb"],
        strSportIconGreen: json["strSportIconGreen"],
        strSportDescription: json["strSportDescription"],
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map["idSport"] = idSport;
    map["strSport"] = strSport;
    map["strFormat"] = strFormat;
    map["strSportThumb"] = strSportThumb;
    map["strSportIconGreen"] = strSportIconGreen;
    map["strSportDescription"] = strSportDescription;
    return map;
  }
}
