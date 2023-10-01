
class ChatModel {
  String? idFrom;
  String? name;
  String? timestamp;
  String? content;

  ChatModel(
      {required this.idFrom,
        required this.name,
        required this.timestamp,
        required this.content,});

  ChatModel.fromJson(Map<String, dynamic> json) {
    idFrom = json['idFrom'];
    name = json['name'];
    timestamp = json['timestamp'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFrom'] = this.idFrom;
    data['name'] = this.name;
    data['timestamp'] = this.timestamp;
    data['content'] = this.content;
    return data;
  }
}

