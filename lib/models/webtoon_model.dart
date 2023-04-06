class WebttonModel {
  final String id, title, thumb;

  WebttonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
