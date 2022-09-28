import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/quotes.dart';

class QuoteDetails extends StatefulWidget {
  //const QuoteDetails({ Key? key }) : super(key: key);
  static const routeName = 'rouetName';

  @override
  State<QuoteDetails> createState() => _QuoteDetailsState();
}

class _QuoteDetailsState extends State<QuoteDetails> {
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final _globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  var _quoteItem =
      QuoteItem(id: '', title: '', description: '', time: DateTime.now());

  @override
  Widget build(BuildContext context) {
    final quoteId = ModalRoute.of(context)!.settings.arguments as String;

    QuoteItem _quote =
        Provider.of<Quotes>(context, listen: false).findQuoteWithId(quoteId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(routeName, arguments: _quote);
                //Todo- show edit bottomsheet
                editQuote(_quote, context);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                deleteQuote(_quote.id, context);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _quote.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      _quote.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void editQuote(QuoteItem quote, BuildContext context) {
    showModalBottomSheet(
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
                    'Update Quote',
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
                        onPressed: updateQuote,
                        child: const Text('Submit')),
                  )
                ],
              ),
            )));
  }

  void updateQuote() {
    bool validated = _globalKey.currentState!.validate();
    if (validated) {
      _globalKey.currentState!.save();

      //update quotelist here

    }
  }

  void deleteQuote(String id, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Quotes>(context, listen: false).deleteQuote(id);

    Navigator.of(context).pop();
  }
}
