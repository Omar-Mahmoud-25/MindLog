class Entry {
  final String date;
  final String text;
  final String title;

  Entry({required this.date,required this.text,required this.title});

  Map<String, dynamic> toJson() => {
        'date': date,
        'text': text,
        'title': title,
      };

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        date: json['date'],
        text: json['text'],
        title: json['title'],
      );
}