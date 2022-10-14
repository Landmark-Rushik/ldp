import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ldp/drower.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;
import 'loaders/color_loader_3.dart';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class change_password extends StatefulWidget {
  const change_password({Key? key}) : super(key: key);

  @override
  State<change_password> createState() => _change_passwordState();
}

var txt_Password = TextEditingController();
var txt_new_Password = TextEditingController();
var txt_new_confirm_Password = TextEditingController();

final userPool = CognitoUserPool(
  'ap-south-1_KOEA2NMTj',
  '2kcreqjc3tingbgkidknq1spte',
);

class _change_passwordState extends State<change_password> {
  bool _obscuredText_old = true;
  bool _obscuredText_new = true;
  bool _obscuredText_confirm = true;

  String Username = "";

  @override
  void initState() {
    // TODO: implement initState

    txt_Password.text = "";
    txt_new_Password.text = "";
    txt_new_confirm_Password.text = "";

    Check_Username();
  }

  Check_Username() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'dict_login_detail';
    final myStringList = prefs.getStringList('dict_login_detail') ?? [];
    print(myStringList);
    globals.User_detail = json.decode(myStringList.toString());
    print(globals.User_detail);

    setState(() {
      Username = globals.User_detail[3]["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    double white_bg_width = 0;
    double white_bg_height = 0;

    bool is_desktop = false;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        is_desktop = true;
        white_bg_width = 550;
        white_bg_height = 550;
        break;
      case DeviceScreenType.tablet:
        is_desktop = true;
        white_bg_width = 450;
        white_bg_height = 550;
        break;
      case DeviceScreenType.mobile:
        is_desktop = false;
        white_bg_width = 300;
        white_bg_height = 550;
        break;
      case DeviceScreenType.Mobile:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Tablet:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Desktop:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Watch:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.watch:
        // TODO: Handle this case.
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            is_desktop
                ? Image.asset(
                    'assets/img/logo-white.png',
                    fit: BoxFit.cover,
                    height: 40,
                  )
                : Container(),
            Spacer(),
            Text('Change Password'),
            Spacer(),
            // IconButton(
            //   icon: Icon(Icons.manage_accounts_outlined),
            //   onPressed: () => {},
            // ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/main_bg.png"),
                fit: BoxFit.cover,
              ),

              // image: new DecorationImage(
              //     fit: BoxFit.cover,
              //     image: Image.asset('assets/img/1.png'),
              //     // image: new NetworkImage('http://3.110.226.63/lis_plus_2_0/public/assets/images/background-img.jpg')
              //         )
            ),
          ),

          // Container(
          //   height: 200,
          //   color: Colors.amber,
          // ),

          Center(
            child: Container(
              // color: Color.fromARGB(24, 0, 0, 0),
              width: white_bg_width,
              height: white_bg_height,
              decoration: BoxDecoration(
                color: Color.fromARGB(24, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 0, 0, 0),
                  style: BorderStyle.solid,
                ),
              ),
              child: SingleChildScrollView(
                // padding: EdgeInsets.all(30.0),
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 200,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/brand_logo.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Change Password : ' + Username,
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: txt_Password,
                      // obscureText: true,
                      obscureText: _obscuredText_old,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black45,
                          hintText: 'Old Password',
                          suffixIcon: FlatButton(
                              // onPressed: _toggle,
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  _obscuredText_old = !_obscuredText_old;
                                });
                              },
                              child: Icon(Icons.remove_red_eye,
                                  color: _obscuredText_old
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(137, 153, 153, 153)))),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: txt_new_Password,
                      // obscureText: true,
                      obscureText: _obscuredText_new,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black45,
                          hintText: 'New Password',
                          suffixIcon: FlatButton(
                              // onPressed: _toggle,
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  _obscuredText_new = !_obscuredText_new;
                                });
                              },
                              child: Icon(Icons.remove_red_eye,
                                  color: _obscuredText_new
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(137, 153, 153, 153)))),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: txt_new_confirm_Password,
                      // obscureText: true,
                      obscureText: _obscuredText_confirm,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black45,
                          hintText: 'Retype new password',
                          suffixIcon: FlatButton(
                              // onPressed: _toggle,
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  _obscuredText_confirm =
                                      !_obscuredText_confirm;
                                });
                              },
                              child: Icon(Icons.remove_red_eye,
                                  color: _obscuredText_confirm
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(137, 153, 153, 153)))),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    MaterialButton(
                      height: 50.0,
                      minWidth: 200.0,
                      color: Color.fromARGB(208, 0, 0, 0),
                      textColor: Colors.white,
                      child: new Text(
                        "Submit",
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () => {change_password_call()},
                      splashColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: drower(),
    );
  }

  change_password_call() async {
    print('handle_New_Password_challenge_call');

    print(txt_Password.text);
    print(txt_new_Password.text);
    print(txt_new_confirm_Password.text);

    if (txt_Password.text.length > 0 &&
        txt_new_Password.text.length > 0 &&
        txt_new_confirm_Password.text.length > 0) {
      if (txt_new_Password.text == txt_new_confirm_Password.text) {
        if (txt_Password.text != txt_new_Password.text) {
          var result = await Connectivity().checkConnectivity();

          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi ||
              result == ConnectivityResult.ethernet) {
            globals.str_loding = "Changing password...";
            start_Loding();
            handle_Change_Password_call_API_call();
          } else {
            AwesomeDialog(
                    dismissOnTouchOutside: false,
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.TOPSLIDE,
                    title: 'No Internet Conectivity ... !',
                    desc:
                        'You are not connected to the internet.\nInternet conection required.',
                    btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {})
                .show();
          }
        } else {
          AwesomeDialog(
                  dismissOnTouchOutside: false,
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.TOPSLIDE,
                  title:
                      'New password must not be the same as your old password!',
                  desc: '',
                  btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
                  // btnCancelOnPress: () {},
                  btnOkOnPress: () {})
              .show();
        }
      } else {
        AwesomeDialog(
                dismissOnTouchOutside: false,
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.TOPSLIDE,
                title:
                    'New password and retyped new password must be the same!',
                desc: '',
                btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
                // btnCancelOnPress: () {},
                btnOkOnPress: () {})
            .show();
      }
    } else {
      AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title:
                  'Old password, new password & retyped new password are mandatory fields.',
              desc: '',
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }

  handle_Change_Password_call_API_call() async {
    // final cognitoUser = CognitoUser(globals.str_CognitoUser, userPool);

    bool passwordChanged = false;
    try {
      passwordChanged = await globals.cognitoUser.changePassword(
        txt_Password.text,
        txt_new_Password.text,
      );

      stop_Loding();

      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.TOPSLIDE,
          title: 'Password changed successfully',
          desc: 'Please login with the new password',
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            globals.str_token = "";

            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          }).show();
    } catch (e) {
      print(e);

      stop_Loding();

      AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.TOPSLIDE,
              title: '',
              desc: e.toString(),
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
    print(passwordChanged);
  }

  void start_Loding() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Stack(
            children: <Widget>[
              Image.asset(
                // 'images/img_vw_logo.png',
                'assets/img/loding_logo/loding_logo.png',
                width: 70,
                height: 70,
                // fit: BoxFit.scaleDown,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ColorLoader3(
                    radius: 35.0,
                    dotRadius: 6.0,
                  ),

                  // ColorLoader2(),

                  // Text('Heartbeat'),
                  SizedBox(width: 20.0),

                  Flexible(
                    child: Container(
                      // padding: EdgeInsets.all(15.0),
                      // padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        // color: Color.fromRGBO(19, 38, 89, 0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0),
                        ),
                      ),

                      // child: JumpingText('Login...'),
                      child: RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          // style: new TextStyle(
                          //   fontSize: 20.0,
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          children: <TextSpan>[
                            TextSpan(
                                text: globals.str_loding,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(19, 38, 89, 1.0))),
                            TextSpan(
                                text: '\nPlease wait...',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0,
                                    color: Color.fromRGBO(19, 38, 89, 1.0))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void stop_Loding() {
    Navigator.of(context).pop();
  }
}
