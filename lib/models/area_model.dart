class Area  {
  String id;
  String area;
  String step;
  String sector;
 

  Area({this.id, this.area, this.step, this.sector});
  Map<String, dynamic> toJson() => {
        "area": "$area",
        "step": "$step",
        "sector": "$sector",
        "id": "$id",
      };



  Area fromJson(Map<String, dynamic> parsedJson) {
    return  Area.fromJson(parsedJson);
  }

  Area.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['_id'].toString();
    area = parsedJson['area'].toString();
    step = parsedJson['step'].toString();
    sector = parsedJson['sector'].toString();
  }
}

