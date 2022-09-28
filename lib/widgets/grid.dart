import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/quote_item_layout.dart';

import '../providers/quotes.dart';

class QuotesGrid extends StatelessWidget {
  //const QuotesGrid({Key? key}) : super(key: key);
  bool isShowingFavorite;
  QuotesGrid(this.isShowingFavorite);

  @override
  Widget build(BuildContext context) {
    final quotesData = Provider.of<Quotes>(context);

    List<QuoteItem> _quoteList =
        isShowingFavorite ? quotesData.myFavorites : quotesData.myQuotes;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _quoteList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (BuildContext context, int index) =>
          ChangeNotifierProvider.value(
        value: _quoteList[index],
        child: QuotesLayout(
          id: _quoteList[index].id,
          title: _quoteList[index].title,
          description: _quoteList[index].description,
          dateTime: _quoteList[index].time,
          isFavorite: _quoteList[index].isFavorite,
        ),
      ),
    );
  }
}
