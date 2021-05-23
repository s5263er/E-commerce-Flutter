import 'package:flutter/material.dart';
import 'package:flutter_app/details/profile_screen.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/search/search_history.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rounded_input_field.dart';
import '../textStyle.dart';
import '../text_field_container.dart';
import '../welcome.dart';
import 'constants.dart';
import 'body.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/myStore.dart';

class HomeScreen extends StatefulWidget {




  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    int _currentPage = 0;

    final List _pages = [
      HomeScreen(),
      Search(),
      store.login ? ProfileScreen(username: store.username) : WelcomeScreen(),
      CartScreen()
    ];
    return Scaffold(
      backgroundColor: Color(0xFF3D3D3D),
      appBar: buildTest(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentPage,
        onTap: (i) {
          setState(() {
            if (i != _currentPage){
              _currentPage = i;
              if(_pages[_currentPage] == Search()){
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return _pages[_currentPage];
                  },
                ),
              );
            }});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.black54,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_alt),
            //title: Text("Filter"),
            label: "Filter",

            backgroundColor: Colors.black54,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
            backgroundColor: Colors.black54,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Cart",
            backgroundColor: Colors.black54,

          ),
        ],
      ),
      body: Body(),
    );
  }

  AppBar buildTest(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () {
          /*globalString = 'id1';
          globaldesc = false;
          globalasc = false;
          Navigator.of(context).pop();*/
        }
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        }),

      ],

      centerTitle: true,
      title: Text(
        "TechIst",
        style: GoogleFonts.lato(
          textStyle: styleAppBar,
        ),
      ),


    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,


      actions: <Widget>[

        /*IconButton(
          icon: SvgPicture.asset(
            "assets/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),*/
        /*IconButton(
          icon: SvgPicture.asset(
            "assets/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: ()  {
                    Navigator.push(
                      context,
                    MaterialPageRoute(
                    builder: (context) {
                    return CartScreen();
                    },
                    ),
                    );
                    },
        ),*/
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
