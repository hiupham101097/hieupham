class MessageModal {
  String code;
  int number;
  String title;
  String? content;

  MessageModal(
    this.code, {
    this.title = "",
    this.content = "",
    this.number = 0,
  });
}
