class Messages {
  final String message;
  final String id;

  Messages(this.id, this.message);

  factory Messages.fromJson(jsonData) {
    return Messages(jsonData['id'], jsonData['message']);
  }
}
