import 'package:flutter/cupertino.dart';

class QuoteItem {
  String id, description, title;
  DateTime time;
  bool isFavorite;

  QuoteItem(
      {required this.id,
      required this.title,
      required this.description,
      this.isFavorite=false,
      required this.time});
}

class Quotes with ChangeNotifier {
  final List<QuoteItem> _quoteList = [
    QuoteItem(
        id: DateTime.now().toString(),
        title: 'Hello Charles..',
        description:
            'This is a dummy descripton, so dont take it seriously... Houses less than 400 £ a month, look horrible.',
        isFavorite: false,
        time: DateTime.now()),
    QuoteItem(
        id: DateTime.now().toString(),
        title: 'Hello Charles..',
        description:
            'This is a dummy descripton, so dont take it seriously... Houses less than 400 £ a month, look horrible.',
        isFavorite: false,
        time: DateTime.now()),
    QuoteItem(
        id: DateTime.now().toString(),
        title: 'Hello Charles..',
        description:
            'This is a dummy descripton, so dont take it seriously... Houses less than 400 £ a month, look horrible.',
        isFavorite: false,
        time: DateTime.now()),
    QuoteItem(
        title: 'Hello Charles..',
        id: DateTime.now().toString(),
        description:
            'This is a dummy descripton, so dont take it seriously... Houses less than 400 £ a month, look horrible.',
        isFavorite: false,
        time: DateTime.now()),
    QuoteItem(
        title: 'Hello Charles..',
        id: DateTime.now().toString(),
        description:
            'This is a dummy descripton, so dont take it seriously... Houses less than 400 £ a month, look horrible.',
        isFavorite: false,
        time: DateTime.now()),
  ];

  List<QuoteItem> get myQuotes => [..._quoteList];

  QuoteItem findQuoteWithId(String quoteId) {
    return _quoteList.firstWhere((element) => element.id == quoteId);
  }

 Future<void> addQuotes(QuoteItem item) async {
    _quoteList.insert(0, item);
    notifyListeners();
  }
}
