import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:todo_app/widgets/quote_item_layout.dart';
import 'package:http/http.dart' as http;
import '../providers/quotes.dart';
import '../widgets/grid.dart';

enum display { Favorite, All }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({ Key? key }) : super(key: key);
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final _globalKey = GlobalKey<FormState>();

  var _quoteItem =
      QuoteItem(id: '', title: '', description: '', time: DateTime.now());

  Future getBottomsheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        builder: (_) => Container(
              color: const Color.fromARGB(255, 224, 222, 222),
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              iconSize: 40,
                              color: Color.fromARGB(255, 169, 24, 14),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add Quote',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: ((newValue) {
                        _quoteItem = QuoteItem(
                            id: _quoteItem.id,
                            title: newValue.toString(),
                            description: _quoteItem.description,
                            time: _quoteItem.time);
                      }),
                      onFieldSubmitted: (value) =>
                          descriptionFocusNode.requestFocus(),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'No title found!';
                        }
                        return null;
                      }),
                      focusNode: titleFocusNode,
                      decoration: const InputDecoration(
                          label: Text(
                        'Enter title',
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: ((newValue) {
                        _quoteItem = QuoteItem(
                            id: _quoteItem.id,
                            title: _quoteItem.title,
                            description: newValue.toString(),
                            time: _quoteItem.time);
                      }),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'No description found!';
                        }
                        return null;
                      }),
                      focusNode: descriptionFocusNode,
                      decoration: const InputDecoration(
                          label: Text(
                        'Enter description',
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          onPressed: addNewQuote,
                          child: const Text('Submit')),
                    )
                  ],
                ),
              ),
            ));
  }

  void addNewQuote() async {
    final isValidated = _globalKey.currentState!.validate();
    if (isValidated) {
      _globalKey.currentState!.save();
    } else {
      return;
    }

    Provider.of<Quotes>(context, listen: false).addQuotes(_quoteItem);
    Navigator.of(context).pop();
  }

  bool isShowFavorite = false;

  @override
  void initState() {
    Provider.of<Quotes>(context, listen: false).retrieveQuotesFromDatabase();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final quotesData = Provider.of<Quotes>(context);

    List<QuoteItem> _quoteList =
        isShowFavorite ? quotesData.myFavorites : quotesData.myQuotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 17),
            child: PopupMenuButton(
                onSelected: (display show) {
                  switch (show) {
                    case display.Favorite:
                      setState(() {
                        isShowFavorite = true;
                      });
                      break;

                    case display.All:
                      setState(() {
                        isShowFavorite = false;
                      });
                      break;
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('Favorites'),
                        value: display.Favorite,
                      ),
                      const PopupMenuItem(
                        child: Text('Show All'),
                        value: display.All,
                      )
                    ]),
          ),
        ],
      ),
      body: QuotesGrid(isShowFavorite),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getBottomsheet(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
