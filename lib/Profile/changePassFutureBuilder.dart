
/*
import 'package:awesome_dialog/awesome_dialog.dart';
import "package:flutter/material.dart";

import 'changePass.dart';

class changePassDialog extends StatelessWidget {

  changePassDialog({Key key,this.username,this.password,this.newpassword}) : super(key: key);
  final String username,password,newpassword;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ChangePass(username, password, newpassword),
      builder: (context, snapshot) {
        print(snapshot.data);
        print("girdi mi ? ${snapshot.hasData}");
        if(snapshot.hasData){
          print(snapshot.data);
          if(snapshot.data == true)
          {
            print("girdi");
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Password Changed')));
            AwesomeDialog(
                context: context,
                animType: AnimType.LEFTSLIDE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                title: 'Succes',
                desc:
                'Dialog description here..................................................',
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDissmissCallback: () {
                  debugPrint('Dialog Dissmiss from callback');
                })
              ..show();
            return changePass();
          }
          if(snapshot.data == false){
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Incorrect Current Password')));
            AwesomeDialog(
                context: context,
                animType: AnimType.LEFTSLIDE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                title: 'Succes',
                desc:
                'Dialog description here..................................................',
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDissmissCallback: () {
                  debugPrint('Dialog Dissmiss from callback');
                })
              ..show();
            return changePass();
          }
        }

        else{
          print("girmedi");
          return changePass();
        }
        return changePass();
      },
    );
  }
}
*/