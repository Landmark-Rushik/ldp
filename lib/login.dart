// import 'dart:ffi';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ldp/dashboard.dart';
import 'package:ldp/loaders/color_loader_2.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'globals.dart' as globals;
import 'loaders/color_loader_3.dart';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:flutter/material.dart';

// import 'amplifyconfiguration.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

final userPool = CognitoUserPool(
  'ap-south-1_KOEA2NMTj',
  '2kcreqjc3tingbgkidknq1spte',
);

class _loginState extends State<login> {
  String _selectedCompany = 'Select a company';

  // Initially password is obscure
  bool _obscuredText = true;
  bool _is_forgot_Password_clicked = false;

  bool _is_handle_New_Password_challenge = false;
  bool is_get_Recovery_code = false;

  // late String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // void _configureAmplify() async {
  //   try {
  //     await Amplify.addPlugin(AmplifyAuthCognito());
  //     await Amplify.configure(amplifyconfig);
  //     print('Successfully configured');
  //   } on Exception catch (e) {
  //     print('Error configuring Amplify: $e');
  //   }
  // }

  var txt_Username = TextEditingController();
  var txt_Password = TextEditingController();
  var txt_new_Password = TextEditingController();
  var txt_new_confirm_Password = TextEditingController();
  var txt_recovery_code = TextEditingController();
  var txt_set_new_password = TextEditingController();

  bool _obscuredText_new_Password = true;
  bool _obscuredText_new_confirm_Password = true;
  bool _obscuredText_recovery_code = true;
  bool _obscuredText_set_new_password = true;

  // String str_CognitoUsername = "";

  String msg = "";

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    double white_bg_width = 0;
    double white_bg_height = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        white_bg_width = 550;
        white_bg_height = 550;
        break;
      case DeviceScreenType.tablet:
        white_bg_width = 450;
        white_bg_height = 550;
        break;
      case DeviceScreenType.mobile:
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/login_bg_web.png"),
                fit: BoxFit.cover,
              ),

              // image: new DecorationImage(
              //     fit: BoxFit.cover,
              //     image: Image.asset('assets/img/1.png'),
              //     // image: new NetworkImage('http://3.110.226.63/lis_plus_2_0/public/assets/images/background-img.jpg')
              //         )
            ),
          ),
          Center(
            child: Container(
              color: Colors.white12,
              width: white_bg_width,
              height: white_bg_height,
              child: SingleChildScrollView(
                // padding: EdgeInsets.all(30.0),
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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

                    _is_handle_New_Password_challenge
                        ? Container()
                        : _is_forgot_Password_clicked
                            ? Text(
                                'Forgot your password ?',
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500),
                              )
                            : Container(),
                    _is_forgot_Password_clicked
                        ? SizedBox(
                            height: 15.0,
                          )
                        : Container(),

// OPEN WHEN REQUIRED ############################################################
                    // _is_handle_New_Password_challenge
                    //     ? Container()
                    //     : _is_forgot_Password_clicked
                    //         ? Container()
                    //         : DropdownButtonFormField<String>(
                    //             value: null,
                    //             isDense: true,
                    //             style: TextStyle(color: Colors.white),
                    //             dropdownColor: Color.fromARGB(174, 0, 0, 0),
                    //             decoration: InputDecoration(
                    //               prefixIcon: Icon(
                    //                 Icons.car_repair,
                    //                 color: Colors.white,
                    //               ),
                    //               hintStyle: TextStyle(color: Colors.white),
                    //               filled: true,
                    //               fillColor: Colors.black45,
                    //             ),
                    //             icon: Icon(
                    //               Icons.keyboard_double_arrow_down_rounded,
                    //               color: Colors.white,
                    //             ),
                    //             // dropdownColor: Colors.black45,
                    //             hint: Text(
                    //               _selectedCompany,
                    //               style: new TextStyle(
                    //                   fontSize: 15.0,
                    //                   color: Color.fromARGB(255, 255, 255, 255),
                    //                   fontWeight: FontWeight.w300),
                    //             ),
                    //             onChanged: (newVal) {
                    //               setState(() {
                    //                 _selectedCompany = newVal!;
                    //               });
                    //             },
                    //             items: <String>[
                    //               'Group Landmark',
                    //               'Mercedes-Benz',
                    //               'Honda',
                    //               'Volkswagen',
                    //               'Renault',
                    //               'Jeep',
                    //               // 'Group Landmark1',
                    //               // 'Mercedes-Benz1',
                    //               // 'Honda1',
                    //               // 'Volkswagen1',
                    //               // 'Renault1',
                    //               // 'Jeep1',
                    //               // 'Group Landmark2',
                    //               // 'Mercedes-Benz2',
                    //               // 'Honda2',
                    //               // 'Volkswagen2',
                    //               // 'Renault2',
                    //               // 'Jeep2',
                    //             ].map((String value) {
                    //               return DropdownMenuItem(
                    //                 value: value,
                    //                 child: Text(value),
                    //               );
                    //             }).toList(),
                    //           ),
//  ############################################################

                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       prefixIcon: Icon(
                    //         Icons.car_repair,
                    //         color: Colors.white,
                    //       ),
                    //       hintStyle: TextStyle(color: Colors.white),
                    //       filled: true,
                    //       fillColor: Colors.black45,
                    //       hintText: 'Select Company'),
                    // ),
                    SizedBox(
                      height: 10.0,
                    ),

                    _is_handle_New_Password_challenge
                        ? Text(
                            msg + '\n',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500),
                          )
                        : TextFormField(
                            controller: txt_Username,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.black45,
                                hintText: 'Username'),
                          ),

                    SizedBox(
                      height: 10.0,
                    ),

                    _is_handle_New_Password_challenge
                        ? Column(
                            children: [
                              TextFormField(
                                controller: txt_Password,
                                obscureText: _obscuredText,
                                // obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.black45,
                                    hintText: 'Old Password',
                                    suffixIcon: FlatButton(
                                        // onPressed: _toggle,
                                        minWidth: 30,
                                        onPressed: () {
                                          setState(() {
                                            _obscuredText = !_obscuredText;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye,
                                            color: _obscuredText
                                                ? Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Color.fromARGB(
                                                    137, 153, 153, 153)))),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: txt_new_Password,
                                obscureText: _obscuredText_new_Password,
                                // obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.black45,
                                    hintText: 'New Password',
                                    suffixIcon: FlatButton(
                                        // onPressed: _toggle,
                                        minWidth: 30,
                                        onPressed: () {
                                          setState(() {
                                            _obscuredText_new_Password =
                                                !_obscuredText_new_Password;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye,
                                            color: _obscuredText_new_Password
                                                ? Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Color.fromARGB(
                                                    137, 153, 153, 153)))),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: txt_new_confirm_Password,
                                obscureText: _obscuredText_new_confirm_Password,
                                // obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.black45,
                                    hintText: 'Confirm New Password',
                                    suffixIcon: FlatButton(
                                        // onPressed: _toggle,
                                        minWidth: 30,
                                        onPressed: () {
                                          setState(() {
                                            _obscuredText_new_confirm_Password =
                                                !_obscuredText_new_confirm_Password;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye,
                                            color:
                                                _obscuredText_new_confirm_Password
                                                    ? Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    : Color.fromARGB(
                                                        137, 153, 153, 153)))),
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
                                onPressed: () =>
                                    {handle_New_Password_challenge_call()},
                                splashColor: Theme.of(context).primaryColor,
                              ),
                              // ButtonTheme(
                              //   // minWidth: 200.0,
                              //   // height: 50.0,
                              //   child: ElevatedButton(
                              //     child: Text('Login'),
                              //     onPressed: () {},
                              //     style: ElevatedButton.styleFrom(
                              //         primary: Color.fromARGB(208, 0, 0, 0),
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 50, vertical: 20),
                              //         textStyle: TextStyle(
                              //             fontSize: 25,
                              //             fontWeight: FontWeight.w500)),
                              //   ),
                              // ),
                            ],
                          )
                        : _is_forgot_Password_clicked
                            ? Column(
                                children: [
                                  is_get_Recovery_code
                                      ? Column(children: [
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          TextFormField(
                                            controller: txt_recovery_code,
                                            // obscureText: true,
                                            obscureText:
                                                _obscuredText_recovery_code,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                filled: true,
                                                fillColor: Colors.black45,
                                                hintText: 'OTP',
                                                suffixIcon: FlatButton(
                                                    // onPressed: _toggle,
                                                    minWidth: 30,
                                                    onPressed: () {
                                                      setState(() {
                                                        _obscuredText_recovery_code =
                                                            !_obscuredText_recovery_code;
                                                      });
                                                    },
                                                    child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            _obscuredText_recovery_code
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)
                                                                : Color
                                                                    .fromARGB(
                                                                        137,
                                                                        153,
                                                                        153,
                                                                        153)))),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          TextFormField(
                                            controller: txt_set_new_password,
                                            // obscureText: true,
                                            obscureText:
                                                _obscuredText_set_new_password,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                filled: true,
                                                fillColor: Colors.black45,
                                                hintText: 'Set New Password',
                                                suffixIcon: FlatButton(
                                                    // onPressed: _toggle,
                                                    minWidth: 30,
                                                    onPressed: () {
                                                      setState(() {
                                                        _obscuredText_set_new_password =
                                                            !_obscuredText_set_new_password;
                                                      });
                                                    },
                                                    child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            _obscuredText_set_new_password
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)
                                                                : Color
                                                                    .fromARGB(
                                                                        137,
                                                                        153,
                                                                        153,
                                                                        153)))),
                                          ),
                                        ])
                                      : Container(),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaterialButton(
                                        height: 50.0,
                                        minWidth: 100.0,
                                        color: Color.fromARGB(208, 0, 0, 0),
                                        textColor: Colors.white,
                                        child: new Text(
                                          "Cancel",
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () => {
                                          // setState(() {
                                          //
                                          // }),

                                          setState(() {
                                            is_get_Recovery_code = false;
                                            _is_forgot_Password_clicked = false;
                                          }),
                                        },
                                        splashColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      is_get_Recovery_code
                                          ? MaterialButton(
                                              height: 50.0,
                                              minWidth: 100.0,
                                              color:
                                                  Color.fromARGB(208, 0, 0, 0),
                                              textColor: Colors.white,
                                              child: new Text(
                                                "Submit",
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () => {
                                                Recovery_code_call()

                                                // setState(() {
                                                //   _is_forgot_Password_clicked = false;
                                                // }),
                                              },
                                              splashColor: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : MaterialButton(
                                              height: 50.0,
                                              minWidth: 100.0,
                                              color:
                                                  Color.fromARGB(208, 0, 0, 0),
                                              textColor: Colors.white,
                                              child: new Text(
                                                "Submit",
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () => {
                                                handle_Forgot_Password_challenge_call()

                                                // setState(() {
                                                //   _is_forgot_Password_clicked = false;
                                                // }),
                                              },
                                              splashColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  TextFormField(
                                    controller: txt_Password,
                                    obscureText: _obscuredText,
                                    // obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        fillColor: Colors.black45,
                                        hintText: 'Password',
                                        suffixIcon: FlatButton(
                                            // onPressed: _toggle,
                                            minWidth: 30,
                                            onPressed: () {
                                              setState(() {
                                                _obscuredText = !_obscuredText;
                                              });
                                            },
                                            child: Icon(Icons.remove_red_eye,
                                                color: _obscuredText
                                                    ? Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    : Color.fromARGB(
                                                        137, 153, 153, 153)))),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      // TODO Social Icons
                                      FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              _is_forgot_Password_clicked =
                                                  true;
                                            });
                                          },
                                          child: Text(
                                            'Forgot your password?',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ],
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
                                      "Login",
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () => {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => dashboard()),
                                      // ).then((value) {}),
                                      login_call()
                                    },
                                    splashColor: Theme.of(context).primaryColor,
                                  ),
                                  // ButtonTheme(
                                  //   // minWidth: 200.0,
                                  //   // height: 50.0,
                                  //   child: ElevatedButton(
                                  //     child: Text('Login'),
                                  //     onPressed: () {},
                                  //     style: ElevatedButton.styleFrom(
                                  //         primary: Color.fromARGB(208, 0, 0, 0),
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: 50, vertical: 20),
                                  //         textStyle: TextStyle(
                                  //             fontSize: 25,
                                  //             fontWeight: FontWeight.w500)),
                                  //   ),
                                  // ),
                                ],
                              ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  handle_New_Password_challenge_call() async {
    print('handle_New_Password_challenge_call');

    print(txt_Password.text);
    print(txt_new_Password.text);
    print(txt_new_confirm_Password.text);
    print(globals.str_CognitoUsername);

    if (txt_new_Password.text.length > 0 &&
        txt_new_confirm_Password.text.length > 0) {
      if (txt_new_Password.text == txt_new_confirm_Password.text) {
        var result = await Connectivity().checkConnectivity();

        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet) {
          globals.str_loding = "Change Password...";
          start_Loding();
          handle_New_Password_challenge_call_API_call();
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
                dialogType: DialogType.WARNING,
                animType: AnimType.TOPSLIDE,
                title: 'New Password & Confirm New Password must be same.',
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
              title: 'New Password & Confirm New Password Required...!',
              desc: '',
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }

  handle_New_Password_challenge_call_API_call() async {
    print(txt_Password.text);
    print(txt_new_Password.text);
    print(txt_new_confirm_Password.text);
    print(globals.str_CognitoUsername);

    final cognitoUser = CognitoUser(txt_Username.text, userPool);
    final authDetails = AuthenticationDetails(
      username: txt_Username.text,
      password: txt_Password.text,
    );
    CognitoUserSession? session;

    try {
      session = (await cognitoUser.authenticateUser(authDetails))!;

      // stop_Loding();
      print("Login Successful...!");
      msg = "Login Successful...!";
      globals.str_token = session.accessToken.jwtToken.toString();
      // globals.str_refresh_token =
      // print("session");
    } on CognitoUserNewPasswordRequiredException catch (e) {
      // handle New Password challenge
      msg = "handle New Password challenge";
      print("handle New Password challenge");

      try {
        if (e.requiredAttributes!.isEmpty) {
          // No attribute hast to be set
          session = (await cognitoUser
              .sendNewPasswordRequiredAnswer(txt_new_confirm_Password.text));

          print("Password Changed Successful...!");
          msg = "Password Changed Successful...!";
          // globals.str_token = session.accessToken.jwtToken.toString();
        } else {
          // All attributes from the e.requiredAttributes has to be set.
          print(e.requiredAttributes);
          // For example obtain and set the name attribute.
          var attributes = {"name": globals.str_CognitoUsername};
          session = (await cognitoUser.sendNewPasswordRequiredAnswer(
              txt_new_confirm_Password.text, attributes))!;

          print("Password Changed Successful...!");
          msg = "Password Changed  Successful...!";
          // globals.str_token = session.accessToken.jwtToken.toString();
        }
      } on CognitoUserMfaRequiredException catch (e) {
        // handle SMS_MFA challenge
        msg = "handle SMS_MFA challenge";
        print("handle SMS_MFA challenge");
      } on CognitoUserSelectMfaTypeException catch (e) {
        // handle SELECT_MFA_TYPE challenge
        msg = "handle SELECT_MFA_TYPE challenge";
        print("handle SELECT_MFA_TYPE challenge");
      } on CognitoUserMfaSetupException catch (e) {
        // handle MFA_SETUP challenge
        msg = "handle MFA_SETUP challenge";
        print("handle MFA_SETUP challenge");
      } on CognitoUserTotpRequiredException catch (e) {
        // handle SOFTWARE_TOKEN_MFA challenge
        msg = "handle SOFTWARE_TOKEN_MFA challenge";
        print("handle SOFTWARE_TOKEN_MFA challenge");
      } on CognitoUserCustomChallengeException catch (e) {
        // handle CUSTOM_CHALLENGE challenge
        msg = "handle CUSTOM_CHALLENGE challenge";
        print("handle CUSTOM_CHALLENGE challenge");
      } on CognitoUserConfirmationNecessaryException catch (e) {
        // handle User Confirmation Necessary
        msg = "handle User Confirmation Necessary";
        print("handle User Confirmation Necessary");
      } on CognitoClientException catch (e) {
        // handle Wrong Username and Password and Cognito Client
        msg = "handle Wrong Username and Password and Cognito Client";
        print("handle Wrong Username and Password and Cognito Client");

        if (e.statusCode == 400) {
          msg = e.message.toString();
          // if (e.message ==
          //     "Password does not conform to policy: Password must have uppercase characters") {
          //   msg = e.message.toString();
          // } else {}
        }
      } catch (e) {
        print(e);
        msg = 'An unknown error occurred';
        print("An unknown error occurred");
      }
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
      msg = "handle SMS_MFA challenge";
      print("handle SMS_MFA challenge");
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE challenge
      msg = "handle SELECT_MFA_TYPE challenge";
      print("handle SELECT_MFA_TYPE challenge");
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
      msg = "handle MFA_SETUP challenge";
      print("handle MFA_SETUP challenge");
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
      msg = "handle SOFTWARE_TOKEN_MFA challenge";
      print("handle SOFTWARE_TOKEN_MFA challenge");
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
      msg = "handle CUSTOM_CHALLENGE challenge";
      print("handle CUSTOM_CHALLENGE challenge");
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
      msg = "handle User Confirmation Necessary";
      print("handle User Confirmation Necessary");
    } on CognitoClientException catch (e) {
      // handle Wrong Username and Password and Cognito Client
      msg = "handle Wrong Username and Password and Cognito Client";
      print("handle Wrong Username and Password and Cognito Client");
    } catch (e) {
      print(e);
      msg = 'An unknown error occurred';
      print("An unknown error occurred");
    }

    if (msg == "Password Changed Successful...!") {
      setState(() {
        _obscuredText = true;
        txt_Password.text = "";
        _is_handle_New_Password_challenge = false;
      });

      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.TOPSLIDE,
          title: msg,
          desc: '', //globals.str_token.toString(),
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            stop_Loding();
            // if (msg == "Password Changed Successful...!") {
            //   setState(() {
            //     txt_Password.text = "";
            //     _is_handle_New_Password_challenge = false;
            //   });
            // }
          }).show();
    } else
      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.TOPSLIDE,
          title: msg,
          desc: globals.str_token.toString(),
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            stop_Loding();
            // if (msg == "Password Changed Successful...!") {
            //   setState(() {
            //     txt_Password.text = "";
            //     _is_handle_New_Password_challenge = false;
            //   });
            // }
          }).show();

    // print(session.getAccessToken().getJwtToken());
    // print("");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => dashboard()),
    // ).then((value) {});
  }

  //  ForgotPassword_call ##########################################################

  handle_Forgot_Password_challenge_call() async {
    print('handle_New_Password_challenge_call');

    print(txt_Password.text);
    print(txt_new_Password.text);
    print(txt_new_confirm_Password.text);
    print(globals.str_CognitoUsername);

    if (txt_Username.text.length > 0) {
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        globals.str_loding = "Sending OTP ...";
        start_Loding();
        handle_Forgot_Password_call_API_call();
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
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title: 'Username Required.',
              desc: '',
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }

  handle_Forgot_Password_call_API_call() async {
    print(txt_Username.text);
    // print(txt_Password.text);

    final cognitoUser = CognitoUser(txt_Username.text, userPool);

    var data;
    try {
      data = await cognitoUser.forgotPassword();

      stop_Loding();

      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.TOPSLIDE,
          title: 'OTP sent',
          desc: data.toString(),
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            setState(() {
              is_get_Recovery_code = true;
            });
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
    print('Code sent to $data');
  }

  Recovery_code_call() async {
    if (txt_Username.text.length > 0 &&
        txt_recovery_code.text.length > 0 &&
        txt_set_new_password.text.length > 0) {
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        globals.str_loding = "Setting new password ...";
        start_Loding();
        Recovery_code_API_call();
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
          dialogType: DialogType.WARNING,
          animType: AnimType.TOPSLIDE,
          title: 'Username, OTP & new password required!',
          desc: '',
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            setState(() {
              is_get_Recovery_code = false;
              _is_forgot_Password_clicked = false;
            });
          }).show();
    }
  }

  Recovery_code_API_call() async {
    print(txt_Username.text);
    // print(txt_Password.text);

    final cognitoUser = CognitoUser(txt_Username.text, userPool);

    // prompt user for verification input...

    bool passwordConfirmed = false;
    try {
      passwordConfirmed = await cognitoUser.confirmPassword(
          txt_recovery_code.text, txt_set_new_password.text);

      stop_Loding();

      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.TOPSLIDE,
          title: 'New password set successfully',
          desc: 'Please login with the new password',
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            setState(() {
              is_get_Recovery_code = false;
              _is_forgot_Password_clicked = false;
            });
          }).show();
    } catch (e) {
      print(e);

      stop_Loding();

      AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.TOPSLIDE,
              title: '',
              desc: e.toString(),
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
    print(passwordConfirmed);
  }

  //  Login_call ###################################################################
  login_call() async {
    print('btn_Login_call');

    if (txt_Username.text.length > 0 && txt_Password.text.length > 0) {
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        globals.str_loding = "Authenticating ...";
        start_Loding();
        Login_API_call();
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
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title: 'Username and Password Required.',
              desc: '',
              btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }

  Login_API_call() async {
    print(txt_Username.text);
    print(txt_Password.text);

    globals.cognitoUser = CognitoUser(txt_Username.text, userPool);

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var jsonList =
    //  globals.cognitoUser;
    // prefs.setStringList('dict_login_detail', jsonList);

    final authDetails = AuthenticationDetails(
      username: txt_Username.text,
      password: txt_Password.text,
    );
    CognitoUserSession session;

    try {
      session = (await globals.cognitoUser.authenticateUser(authDetails))!;

      // stop_Loding();
      print("Login Successful...!");
      msg = "Login Successful...!";
      globals.str_token = session.accessToken.jwtToken.toString();

      // globals.cognitoUser = cognitoUser;
      // globals.cognitoUser = cognitoUser;

      // globals.str_CognitoUsername = session.userAttributes["name"].toString();
      // globals.str_refresh_token =
      // print("session");
    } on CognitoUserNewPasswordRequiredException catch (e) {
      // handle New Password challenge
      globals.str_CognitoUsername = e.userAttributes["name"].toString();

      print("handle New Password challenge");
      setState(() {
        msg = "Login Successful...!\nPlease change Password.";
        _obscuredText = true;
        _is_handle_New_Password_challenge = true;
      });
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
      msg = "handle SMS_MFA challenge";
      print("handle SMS_MFA challenge");
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE challenge
      msg = "handle SELECT_MFA_TYPE challenge";
      print("handle SELECT_MFA_TYPE challenge");
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
      msg = "handle MFA_SETUP challenge";
      print("handle MFA_SETUP challenge");
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
      msg = "handle SOFTWARE_TOKEN_MFA challenge";
      print("handle SOFTWARE_TOKEN_MFA challenge");
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
      msg = "handle CUSTOM_CHALLENGE challenge";
      print("handle CUSTOM_CHALLENGE challenge");
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
      msg = "handle User Confirmation Necessary";
      print("handle User Confirmation Necessary");
    } on CognitoClientException catch (e) {
      // handle Wrong Username and Password and Cognito Client
      msg = "handle Wrong Username and Password and Cognito Client";
      print("handle Wrong Username and Password and Cognito Client");

      globals.str_token = "";
    } catch (e) {
      print(e);
      msg = 'An unknown error occurred';
      print("An unknown error occurred");
    }

    if (msg == "Login Successful...!") {
      stop_Loding();
      start_Loding();
      get_attributes();
      // AwesomeDialog(
      //     dismissOnTouchOutside: false,
      //     context: context,
      //     dialogType: DialogType.SUCCES,
      //     animType: AnimType.TOPSLIDE,
      //     title: msg,
      //     desc: '', //globals.str_token.toString(),
      //     btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
      //     // btnCancelOnPress: () {},
      //     btnOkOnPress: () {
      //       stop_Loding();

      //       if (msg == "Login Successful...!") {
      //         get_attributes();
      //       }
      //     }).show();
    } else if (msg == "Login Successful...!\nPlease change Password.") {
      stop_Loding();
    } else {
      AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.TOPSLIDE,
          title: 'Incorrect username and/or password.',
          desc: '', //globals.str_token.toString(),
          btnOkColor: Colors.cyan, //Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            stop_Loding();

            // if (msg == "Login Successful...!") {
            //   get_attributes();
            // }
          }).show();
    }

    // print(session.getAccessToken().getJwtToken());
    // print("");
  }

  get_attributes() async {
    // List<CognitoUserAttribute> attributes;
    try {
      // attributes = await globals.str_CognitoUser.getUserAttributes();
      globals.attributes = (await globals.cognitoUser.getUserAttributes())!;

      List<dynamic> User_detail = [];

      Map Login_Detail = {};

      globals.attributes.forEach((attribute) {
        print(
            'attribute ${attribute.getName()} has value ${attribute.getValue()}');

        var User_details = {
          'key': attribute.getName(),
          'value': attribute.getValue(),
        };
        User_detail.add(User_details);
      });

      // Login_Detail.addAll(User_detail);

      print(User_detail);

      // Future<void> setList() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> jsonList =
          User_detail.map((item) => jsonEncode(item)).toList();
      prefs.setStringList('dict_login_detail', jsonList);

      stop_Loding();
      globals.str_CognitoUser = txt_Username.text;
      Navigator.pushNamed(context, '/dashboard');
    } catch (e) {
      print(e);

      stop_Loding();
      globals.str_CognitoUser = txt_Username.text;
      Navigator.pushNamed(context, '/dashboard');
    }

    // globals._logger.i("User with following attrbiutes has logged in at datetime");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => dashboard()),
    // ).then((value) {});

    // Navigate to the second screen using a named route.
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
