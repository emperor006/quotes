import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class QuoteItem with ChangeNotifier {
  String id, description, title;
  DateTime time;
  bool isFavorite;

  QuoteItem(
      {required this.id,
      required this.title,
      required this.description,
      this.isFavorite = false,
      required this.time});

  Future<void> toggleFavorites() async {
    isFavorite = !isFavorite;
    await updateFavoriteStatus();
    notifyListeners();
  }

  Future<void> updateFavoriteStatus() async {
    var url =
        'https://quotesapp-af2d3-default-rtdb.firebaseio.com/quotes/$id.json';

    await http.patch(Uri.parse(url),
        body: json.encode({
          'title': title,
          'description': description,
          'time': time.toIso8601String(),
          'isFavorite': isFavorite
        }));

    notifyListeners();
  }
}

class Quotes with ChangeNotifier {
  final List<QuoteItem> _quoteList = [];

  List<QuoteItem> get myQuotes => [..._quoteList];

  QuoteItem findQuoteWithId(String quoteId) {
    return _quoteList.firstWhere((element) => element.id == quoteId);
  }

  List<QuoteItem> get myFavorites {
    return _quoteList.where((element) => element.isFavorite == true).toList();
  }

  Future<void> addQuotes(QuoteItem _quoteItem) async {
    const host = 'quotesapp-af2d3-default-rtdb.firebaseio.com';
    const path = '/quotes.json';
    final response = await http.post(Uri.https(host, path),
        body: json.encode({
          'description': _quoteItem.description,
          'title': _quoteItem.title,
          'isFavorite': _quoteItem.isFavorite,
          'time': _quoteItem.time.toIso8601String(),
        }));

    var newQuote = QuoteItem(
      id: json.decode(response.body)['name'],
      description: _quoteItem.description,
      time: _quoteItem.time,
      title: _quoteItem.title,
      isFavorite: _quoteItem.isFavorite,
    );

    _quoteList.insert(0, newQuote);
    notifyListeners();
  }

  Future<void> deleteQuote(String quoteId) async {
    var url =
        'https://quotesapp-af2d3-default-rtdb.firebaseio.com/quotes/$quoteId.json';

    await http.delete(Uri.parse(url)).then((value) {
      _quoteList.removeWhere((element) => element.id == quoteId);
    });

    notifyListeners();
  }

  Future<void> updateQuote(QuoteItem quoteItem) async {
    var url =
        'https://quotesapp-af2d3-default-rtdb.firebaseio.com/quotes/${quoteItem.id}.json';

    await http.patch(Uri.parse(url),
        body: json.encode({
          'title': quoteItem.title,
          'description': quoteItem.description,
          'time': quoteItem.time.toIso8601String(),
          'isFavorite': quoteItem.isFavorite
        }));

    int index = _quoteList.indexWhere(
      (element) => element.id == quoteItem.id,
    );
    _quoteList.removeAt(index);
    _quoteList.insert(index, quoteItem);

    notifyListeners();
  }

  Future<void> retrieveQuotesFromDatabase() async {
    const url =
        'https://quotesapp-af2d3-default-rtdb.firebaseio.com/quotes.json';

    final response = await http.get(Uri.parse(url));

    final responseMap = json.decode(response.body) as Map<String, dynamic>;
    responseMap.forEach((key, value) {
      _quoteList.add(QuoteItem(
          id: key,
          title: value['title'],
          description: value['description'],
          time: DateTime.parse(value['time']), // value['time'],
          isFavorite: value['isFavorite']));
    });
    notifyListeners();
  }
}
