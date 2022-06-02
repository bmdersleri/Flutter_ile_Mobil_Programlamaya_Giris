class ListResponsePaginationLink {
  String? url;
  String? label;
  bool? active;

  ListResponsePaginationLink({this.url, this.label, this.active});

  ListResponsePaginationLink.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
