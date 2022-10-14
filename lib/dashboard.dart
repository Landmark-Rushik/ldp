import 'package:flutter/material.dart';
import 'package:ldp/drower.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'globals.dart' as globals;

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    globals.loggerfile.d("Login successful...");
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              Text('Dashboard'),
              Spacer(),
              // IconButton(
              //   icon: Icon(Icons.manage_accounts_outlined),
              //   onPressed: () => {},
              // ),
            ],
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/main_bg.png"),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     Colors.white.withOpacity(0.5), BlendMode.dstATop),
            ),
          ),
        ),
        drawer: drower(),
      ),
    );
  }
}
