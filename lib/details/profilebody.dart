import 'package:flutter/material.dart';
import 'package:flutter_app/details/profilemenu.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';



class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [

          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon2: Icons.account_circle,
            press: () => {},
          ),
          ProfileMenu(
            text: "My Orders",
            icon2: Icons.local_shipping_sharp,
            press: () {},
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
    );
  }
}