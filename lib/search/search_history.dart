

import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/details/detailbody.dart';
import 'package:flutter_app/details/details_screen.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/item_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/products/body.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../myStore.dart';
import '../textStyle.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RangeValues _currentRangeValues =  RangeValues(0, 5000);
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    List <Products> _products = [];


    if(globalString == "id2")
    {
      _products = store.computers;


    }
    else if(globalString == "id3"){
      _products = store.tvs;

    }
    else if(globalString == "id4"){
      _products = store.cameras;

    }
    else if(globalString == "id5"){
      _products = store.phones;

    }
    else if(globalString == "id6")
    {
      _products = queryproducts;
    }
    else{

      _products = store.products;
    }
    _products.sort((b,a) => a.rating.compareTo(b.rating));


    return Scaffold(
      backgroundColor: Color(0xFF3D3D3D),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Filter'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Center(


                    child: LiteRollingSwitch(
                    //initial value
                    value: false,
                    textOn: 'Deactivate',
                    textOff: 'Activate',
                    colorOn: Colors.black,
                    colorOff: Colors.white38,
                    iconOn: Icons.filter_list_alt,
                    iconOff: Icons.remove_circle_outline,
                    textSize: 16.0,
                    onChanged: (bool state) {
                      filter = state;
                      if(filter == false)
                        {
                          globalmin = 0;
                          globalmax = 5000;
                          globalasc = false;
                          globaldesc = false;
                        }
                      print('Current State of SWITCH IS: $state');
                    },
                  ),
                  ),





                  Text(
                "Price Range",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  letterSpacing: -1,
                  fontStyle: FontStyle.italic,
                )

                ),
              ) ,
              RangeSlider(
                activeColor: kPrimaryColor,
                inactiveColor: Colors.white,
                values: _currentRangeValues,
                min: 0,
                max: 5000,
                divisions: 25,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                    //print('${values.start}');
                    globalmax = _currentRangeValues.end;
                    globalmin = _currentRangeValues.start;

                  });
                },
              ),
              ToggleSwitch(
                minWidth: 110.0,
                minHeight: 90.0,
                fontSize: 16.0,
                initialLabelIndex: 2,
                activeBgColor: kPrimaryColor,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.grey[900],
                labels: ['Descending', 'Ascending'],
                onToggle: (index) {
                  if(index == 0)
                    {
                      globaldesc = false;
                      globalasc = true;
                    }
                  if(index == 1)
                    {
                      globalasc = false;
                      globaldesc = true;
                    }
                  print('switched to: $index');
                },
              ),
                  AnimatedButton(
                    color: kPrimaryColor,
                    shadowDegree: ShadowDegree.dark,
                    child: Text(
                      "Apply Filters",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),
                    onPressed: (){
                      globalString = "id1";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyApps();
                          },
                        ),
                      );
                    },
                  ),
                  Divider(height: 5, thickness: 2, color: Colors.white70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Best Deals Based on User Reviews",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: -1,
                              fontStyle: FontStyle.italic,
                            )

                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ) ,
                  Container(
                    height: 180,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            return ItemCard(
                                product: _products[i],
                                press: () {
                                  store.setActiveProduct(_products[i]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailsScreen();
                                      },
                                    ),
                                  );
                                }
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:3),
                            child: Container(
                              child: Card(
                                color: Colors.white12,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),

                                    side: BorderSide(width: 1, color: Colors.white)),
                                child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: ItemCard(
                                          product: _products[i],
                                          press: () {
                                            store.setActiveProduct(_products[i]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsScreen();
                                                },
                                              ),
                                            );
                                          }
                                      )
                                  ),

                                ),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0.1,
                                  ),
                                ],
                                //borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
    ],
          ),
      ),

    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String getQ(String which)
  {
    return which;
  }








  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      globalString = 'id1';
      globalmin = 0;
      globalmax = 5000;
      query = "";
    })];
  } //second press geri don

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon:AnimatedIcons.menu_arrow ,progress: transitionAnimation), onPressed: () {
      globalString = 'id1';
      globalmin = 0;
      globalmax = 5000;
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context)
  {
    Future <void> showAlertDialog(String title, String msg) async {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(msg),
                    ],
                  )
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  } ,
                )
              ],

            );
          }

      );
    }




    var store = Provider.of<myStore>(context);
    List<Products> _products = store.products;

    if(globalString == "id2")
    {
      _products = store.computers;

    }
    else if(globalString == "id3"){
      _products = store.tvs;

    }
    else if(globalString == "id4"){
      _products = store.cameras;

    }
    else if(globalString == "id5"){
      _products = store.phones;

    }
    else{

      _products = store.products;

    }

    _products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();

    int count = 0;
    int index = 0;

    for (var i in _products)
      {
        if(i.title == query)
          {
             index = count;
            break;
          }
        else {
          count++;
        }
        print('${i.title} and $query');
        print('$count');
        index = count;
      }
    print("${index}");
    if(index >= _products.length)
      {
        //showAlertDialog('Ups', 'There is no product called $query');
        globalString = "id6";
        queryproducts = _products.where((p) => p.title.toLowerCase().contains(query.toLowerCase())).toList();
        return ItemDisplayer(products: queryproducts, store: store);/*Card(
          color: kPrimaryColor,
          shape: CircleBorder(),
          child: Center(
            child: Text(

              'Sorry we do not have ${query}',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
              textStyle: stylePost,
              color: Colors.yellowAccent,
            ),
            )

          ),
        );*/

      }
      return ItemCard(
          product: _products[index],
          press: () {
            store.setActiveProduct(_products[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailsScreen();
                },
              ),
            );
          }
      );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var store = Provider.of<myStore>(context);
    List<Products> _products = store.products;

    if(globalString == "id2")
    {
      _products = store.computers;

    }
    else if(globalString == "id3"){
      _products = store.tvs;

    }
    else if(globalString == "id4"){
      _products = store.cameras;

    }
    else if(globalString == "id5"){
      _products = store.phones;

    }
    else{

      _products = store.products;

    }
    _products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();

    final suggestionList = query.isEmpty?_products:
    //_products.where((q) => q.description.startsWith(query)).toList();
    _products.where((p) => p.title.toLowerCase().startsWith(query.toLowerCase())).toList();




    return ListView.builder(itemBuilder: (context,index) => ListTile(
      tileColor: Colors.black12,
      onTap: (){
        print("burarararx");
        query = suggestionList[index].title;
        print(_products);

        showResults(context);
      },


      leading: globalString == 'id1' ? iconcu(_products[index]) : globalString == 'id2' ?  Icon(Icons.computer,color: Colors.black) :
      globalString == 'id3' ?  Icon(Icons.tv,color: Colors.black) : globalString == 'id4' ?  Icon(Icons.camera_alt_outlined,color: Colors.black): globalString == 'id5' ?  Icon(Icons.phone_android_rounded,color: Colors.black):Icon(Icons.search,color: Colors.black),

      title: RichText(
        text: TextSpan(
          text: suggestionList[index].title.substring(0,query.length),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(
            text: suggestionList[index].title.substring(query.length),
            style: TextStyle(color: Colors.black),
          )]

        ),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
  
}

Icon iconcu(Products i){


      if(i.categoryid == 0)
        {
          return Icon(Icons.computer);
        }
      if(i.categoryid == 1)
      {
        return Icon(Icons.tv);
      }
      if(i.categoryid == 2)
      {
        return Icon(Icons.camera_alt_outlined);
      }
      if(i.categoryid == 3)
      {
        return Icon(Icons.phone_android_rounded);
      }
    }





/*
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override

  static const historyLength = 3;
  List<String> _searchHistory = [
    'dene',
    'dene2',
  ].reversed;
  List <String> filteredSearchHistory;
  String selectedTerm;

  List <String> filterSearchTerms({
  @required String filter,
}) {
    if(filter != null && filter.isNotEmpty)
      {
        return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
      }
    else {
      return _searchHistory.reversed.toList();
    }

  }

  void addSearchTerm(String term){
    if(_searchHistory.contains(term)) {
      //putSearchTermFirst
      return;
    }

    _searchHistory.add(term);
    if(_searchHistory.length > historyLength)
      {
        _searchHistory.removeRange(0,_searchHistory.length - historyLength);
      }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
     _searchHistory.removeWhere((t) => t == term);
     filteredSearchHistory = filterSearchTerms(filter: null);
  }


  void putSearchTermFirst(String term)
  {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }
  @override
  void initState()
  {
    super.initState();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  FloatingSearchBarController controller;

  @override
  void initState()
  {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }
  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'The Search Bar',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query){
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query){
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context,transition){
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context){
                  // ignore: missing_return, missing_return, missing_return
                  if(filteredSearchHistory.isEmpty && controller.query.isEmpty)
                    {
                      // ignore: missing_return
                      return Container(
                        height: 56,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Start searching',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    }
                  else if(filteredSearchHistory.isEmpty){
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  }
                  else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory.map(
                              (term) => ListTile(
                                title: Text(
                                  term,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: const Icon(Icons.history),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      deleteSearchTerm(term);
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    putSearchTermFirst(term);
                                    selectedTerm = term;
                                  });
                                  controller.close();
                                },


                      ),
                              ).toList(),
                    );
                  }
                },
              )
            ),

          );
        },
      )
    );
  }
}

class SearchResultsListView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


  final fsb = FloatingSearchBar.of(context);

  return ListView(
  padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
  children: List.generate(
    50,
    (index) => ListTile(
      title: Text('$searchTerm search result'),
      subtitle: Text(index.toString()),
        ),
      ),
  );
  }
}
*/