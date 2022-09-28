import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuotesLayout extends StatelessWidget {
  //const QuotesLayout({Key? key}) : super(key: key);
  String title, description;
  DateTime dateTime;
  bool isFavorite;

  QuotesLayout(
      {required this.dateTime,
      required this.description,
      required this.isFavorite,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
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
                DateFormat('dd-MM-yyyy').format(dateTime)  ,
                  style:const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
