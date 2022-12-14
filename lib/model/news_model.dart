class NewsModel {
  String? uuid;
  String? title;
  String? description;
  String? keywords;
  String? snippet;
  String? url;
  String? imageUrl;
  String? language;
  String? publishedAt;
  String? source;
  List<String>? categories;
  String? relevanceScore;

  NewsModel(
      {this.uuid,
      this.title,
      this.description,
      this.keywords,
      this.snippet,
      this.url,
      this.imageUrl,
      this.language,
      this.publishedAt,
      this.source,});

  NewsModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    description = json['description'];
    keywords = json['keywords'];
    snippet = json['snippet'];
    url = json['url'];
    imageUrl = json['image_url'];
    language = json['language'];
    publishedAt = json['published_at'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = uuid;
    data['title'] = title;
    data['description'] = description;
    data['keywords'] = keywords;
    data['snippet'] = snippet;
    data['url'] = url;
    data['image_url'] = imageUrl;
    data['language'] = language;
    data['published_at'] = publishedAt;
    data['source'] = source;
    return data;
  }
}