abstract class IJsonable {
  IJsonable.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
