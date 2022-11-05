import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:string_similarity/string_similarity.dart';


class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {

  // List money= [
  //   {'moneyType': 'Indian rupee'},
  //   {'moneyType': 'United States dollar'},
  //   {'moneyType': 'Australian dollar'},
  //   {'moneyType': 'Euro'},
  //   {'moneyType': 'British pound'},
  //   {'moneyType': 'Yemeni rial'},
  //   {'moneyType': 'Japanese yen'},
  //   {'moneyType': 'Hong Kong dollar'},
  // ];
  List<Currency> money = [
    Currency(currencyType: 'Indian MRF A/T 265/65 R17 rupee'),
    Currency(currencyType: 'United mrf 265/65 R18 16/20 States dollar'),
    Currency(currencyType: 'Australian CEAT 245/65 R17 dollar'),
    Currency(currencyType: 'Euro ceat 245/65 R18 '),
    Currency(currencyType: 'British APOLLO 195/45 R17 pound'),
    Currency(currencyType: 'Yemeni apollo 195/45 R18  rial'),
    Currency(currencyType: 'Japanese GOODYEAR 240/65 R17  yen'),
    Currency(currencyType: 'Hong Kong GoodYear 240/65 R18 15/ 665dollar'),
  ];

  final TextEditingController textController = TextEditingController();
  bool _isSearching = false;
  // var _searchText = '';
  List searchResult = [];

  _SearchListState() {
    textController.addListener(() {
      setState(() {

      });
      if (textController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          // _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          // _searchText = textController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.search,color: Colors.black,),
            SizedBox(width: 2.w,),
            TextField(
              controller: textController,
              onChanged: searchOperation,
              cursorColor: Colors.black,
              cursorHeight: 2.5.h,
              style: const TextStyle(
                fontSize: 17,

              ),
              decoration: InputDecoration(
               filled: true,
                focusColor: Colors.black,
                constraints: BoxConstraints(
                  maxWidth: 70.w,
                  maxHeight: 6.h,
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide( color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                )
              ),),
          ],
        ),
      ),
        
        body: (textController.text.isNotEmpty)
            ?
        ListView.builder(
          itemCount: searchResult.length,
            itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.blueGrey[100],
                  margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 2.w ),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal:2.w, vertical: 2.h),
                    child: Text(
                      '${searchResult[index]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ],
            );

            },
        )
            : ListView.builder(
          itemCount: money.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.blueGrey[100],
                  margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 2.w ),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal:2.w, vertical: 2.h),
                    child: Text(
                      '${money[index].currencyType}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ],
            );

          },
        )
    );
  }
  void searchOperation(String searchText){
    searchResult.clear();
    if (_isSearching != null) {
      String data ='';
      String resultText ='';

      for (int i = 0; i < money.length; i++) {
        data = money[i].currencyType??'';
        // print('ddddddddd $data');
        //   for(int j=0; j<searchText.length; j++){
        //     resultText = searchText.replaceAll('/', ' ');
        //   }
        var similarity = StringSimilarity.compareTwoStrings(data.toLowerCase(), searchText.toLowerCase());
        print('$similarity');
        if (similarity>0.2) {

          searchResult.add(data);
        }
        // if (data.toLowerCase().contains(searchText.toLowerCase())) {
        //   searchResult.add(data);
        // }
      }
    }
  }

}

class Currency {

  String? currencyType;

  Currency ({this.currencyType }) ;

}