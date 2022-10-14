library LDP.globals;

import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:ldp/FileOutput.dart';
import 'package:logger/logger.dart';

String pre_url = "http://lisplus.landmarkbic.com/v1/index.php/api/";

Map Login_Detail = {};

String str_csv_file = "";
String str_loding = "";
String str_loding_logo = 'assets/img/L_logo_1.png';
bool is_loding_logo = true;

String str_token = "";
String str_refresh_token = "";
String str_CognitoUser = "";
String str_CognitoUsername = "";

final userPool = CognitoUserPool(
  'ap-south-1_KOEA2NMTj',
  '2kcreqjc3tingbgkidknq1spte',
);

var cognitoUser = CognitoUser(str_CognitoUser, userPool);
List<CognitoUserAttribute> attributes = [];

List<String> Region_list = [
  'Gujarat',
  'Madhya Pradesh',
  'Mumbai',
  'Kolkata',
  'All Regions'
];

// String str_URL = "http://13.235.82.222:1337/"; // LIVE ...1
// String str_URL = "http://13.235.91.82:1337/"; // LIVE ...2
String str_URL = "http://15.206.17.49:1337/"; // LIVE ...3

// String str_URL = "http://43.204.214.177:5000/"; // Development

var loggerfile = Logger(printer: PrettyPrinter(), output: FileOutput());

// var logger_file;

File? logger_file;

// var logger = Logger();

String logger = "";
List<dynamic> User_detail = [];
