import 'package:flutter/material.dart';
import 'package:flutter_app/PreviousOrders/getOrders.dart';
import 'package:flutter_app/PreviousOrders/previousOrders.dart';
import 'package:flutter_app/Profile/changePass.dart';
import 'package:flutter_app/details/profile_screen.dart';
import 'package:flutter_app/details/profilemenu.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:flutter_app/search/search_history.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';
import '../welcome.dart';



class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    int _currentPage = 3;
    final List _pages = [
      HomeScreen(),
      Search(),
      store.login ? ProfileScreen(username: store.username) : WelcomeScreen(),
      CartScreen()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentPage,
        onTap: (i) {
          setState(() {
            if (i != _currentPage){
            _currentPage = i;
            if(_pages[_currentPage] == Search()){
              /*
              globalmin = 0;
              globalmax = 5000;
              globalasc = false;
              globaldesc = false;*/
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_sharp),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Cart",

          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [

            SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon2: Icons.account_circle,
              press: () => {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) {
              return changePass();
              },
              ),
              )
              },
            ),
            ProfileMenu(
              text: "My Orders",
              icon2: Icons.local_shipping_sharp,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return myOrders();
                    },
                  ),
                );
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon2: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon2: Icons.help_outline_outlined,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon2: Icons.logout,
              press: () {
                store.login = false;
                print(globalToken);
                globalToken = "";
                store.delProducts2();
                pressed = 0;
                store.delProducts2();
                store.delProducts();
                print(globalToken);
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
          ],
        ),
      ),
    );
  }
}