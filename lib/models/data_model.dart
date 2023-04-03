class ObsceneIdentifiedData {
  final double sexual_activity;
  final double sexual_display;
  final double erotica;
  final double suggestive;
  final SuggestiveClasses suggestive_classes;


  ObsceneIdentifiedData({required this.sexual_activity, required this.sexual_display,
    required this.erotica, required this.suggestive,
    required this.suggestive_classes});


  factory ObsceneIdentifiedData.formJson(Map<String, dynamic> json) {
    return ObsceneIdentifiedData(
        sexual_activity: json["sexual_activity"] ?? 0.0,
        sexual_display: json["sexual_display"] ?? 0.0,
        erotica: json['erotica'],
        suggestive: json['suggestive'],
        suggestive_classes: SuggestiveClasses.fromJson(json['suggestive_classes'])
    );
  }
}


class SuggestiveClasses {
  final double bikini;
  final double cleavage;
  final double male_chest;
  final double lingerie;
  final double miniskirt;

  SuggestiveClasses({
    required this.bikini,
    required this.cleavage,
    required this.lingerie,
    required this.male_chest,
    required this.miniskirt
  });

  factory SuggestiveClasses.fromJson(Map<String, dynamic> json){
    return SuggestiveClasses(
        bikini: json["bikini"] ?? 0.0,
        cleavage: json["cleavage"] ?? 0.0,
        lingerie: json['lingerie'] ?? 0.0, male_chest: json['male_chest'] ?? 0.0, miniskirt: json['miniskirt'] ?? 0.0);
  }
}

class ResponseObsceneData {
  final String status;
  final ObsceneIdentifiedData? nudity;

  ResponseObsceneData({required this.status,required this.nudity});

  factory ResponseObsceneData.fromJson(Map<String, dynamic> json) {
    return ResponseObsceneData(status: json["status"], nudity:json["nudity"] == null ? null: ObsceneIdentifiedData.formJson(json["nudity"]));
  }
}

