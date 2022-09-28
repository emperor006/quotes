import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/quotes.dart';
import 'package:todo_app/screens/quotedetails.dart';

class QuotesLayout extends StatefulWidget {
  //const QuotesLayout({Key? key}) : super(key: key);
  String title, description, id;
  DateTime dateTime;
  bool isFavorite;

  QuotesLayout(
      {required this.dateTime,
      required this.id,
      required this.description,
      required this.isFavorite,
      required this.title});

  @override
  State<QuotesLayout> createState() => _QuotesLayoutState();
}

class _QuotesLayoutState extends State<QuotesLayout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(QuoteDetails.routeName, arguments: widget.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(widget.dateTime),
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Consumer<QuoteItem>(builder: ((_, value, child) {
                    return IconButton(
                      onPressed: () {
                        //todo--run update function in server to reflect like
                        value.toggleFavorites();
                      },
                      icon: value.isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border_outlined),
                      color: Colors.red,
                    );
                  }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
