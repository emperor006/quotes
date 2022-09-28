import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/quotes.dart';

class QuoteDetails extends StatelessWidget {
  //const QuoteDetails({ Key? key }) : super(key: key);
  static const routeName = 'rouetName';

  @override
  Widget build(BuildContext context) {
    final quoteId = ModalRoute.of(context)!.settings.arguments as String;
    QuoteItem _quote=Provider.of<Quotes>(context).findQuoteWithId(quoteId);

    return Scaffold(
      appBar: AppBar(title:const Text('Detail Screen')),
      

    );
  }
}
