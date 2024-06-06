import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:midnight_interview_practical/models/login/login_response.dart';
import 'package:midnight_interview_practical/pages/dashboard/dashboard.dart';
import 'package:midnight_interview_practical/utils/constants.dart';
import 'package:midnight_interview_practical/utils/helpers.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../controllers/login/logincontroller.dart';
import '../../services/ApiRequest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _LoginController = Get.put(LoginController());
  final _loginFormKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _LoginController.usernameController.text = "BCON001";
    _LoginController.passwordController.text = "1234";
    initFCMToken();
    initPlatformState();
    initUniqueIdentifierState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.stLoginBackgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 20,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.stHuminImagePath),
                    fit: BoxFit.fill,
                  ),
                ),
                child: null,
              ),
              const SizedBox(height: 20),
              const Text(
                AppConstants.stHuminTitle,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Text(AppConstants.stLogin),
              onPressed: () {
                promptForLoginCredentials();
              },
            ),
          ),
        )
      ]),
    );
  }

  Future<void> initPlatformState() async {
    try {
      _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } on PlatformException {}
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;
    _LoginController.stDeviceId = identifier;
  }

  void _readAndroidBuildData(AndroidDeviceInfo build) {
    _LoginController.stDeviceModel = build.model;
    _LoginController.stOsVersion = build.version.release;
    _LoginController.stMobilePlatform = Platform.operatingSystem;
    /*return <String, dynamic>{
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'host': build.host,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'type': build.type,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
    };*/
  }

  void promptForLoginCredentials() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Colors.blue,
            height: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                        key: _loginFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: _LoginController.usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: AppConstants.stEmpID,
                                  hintText: AppConstants.stEmpID,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ${AppConstants.stEmpID}';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _LoginController.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: AppConstants.stPassword,
                                  hintText: AppConstants.stPassword,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ${AppConstants.stPassword}';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue),
                              child: const Text(AppConstants.stLogin),
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  final loginParams = <String, dynamic>{};
                                  loginParams['employee_id'] = _LoginController
                                      .usernameController.text
                                      .trim()
                                      .toString();
                                  loginParams['userpassword'] = _LoginController
                                      .passwordController.text
                                      .trim()
                                      .toString();
                                  loginParams['fcmToken'] =
                                      _LoginController.stFCMToken;
                                  loginParams['deviceId'] =
                                      _LoginController.stDeviceId;
                                  loginParams['deviceModel'] =
                                      _LoginController.stDeviceModel;
                                  loginParams['osVersion'] =
                                      _LoginController.stOsVersion;
                                  loginParams['mobile_platform'] =
                                      _LoginController.stMobilePlatform;
                                  /*var loginParams = ({
                                    "employee_id": _LoginController.usernameController.text.trim().toString(),
                                    "userpassword": _LoginController.passwordController.text.trim().toString(),
                                    "fcmToken": "LAD000404LAD000404LAD000404LAD000404",
                                    "deviceId": _LoginController.stDeviceId,
                                    "deviceModel": _LoginController.stDeviceModel,
                                    "osVersion": _LoginController.stOsVersion,
                                    "mobile_platform": _LoginController.stMobilePlatform
                                  });*/
                                  callLoginAPI(loginParams);
                                }
                              },
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void callLoginAPI(var params) {
    ApiRequest(
            path: AppConstants.stLoginEndpoint,
            data: params,
            methoud: AppConstants.POST_METHOUD,
            context: context)
        .request(onSuccess: (data, response) {
      LoginResponse loginResponse = LoginResponse.fromJson(response);
      //print("status ${loginResponse.status}");
      if (loginResponse.status == 200) {
        AppHelpers.showShortToast(loginResponse.message!);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => DashboardPage()),
                (route) => false
        );
      } else {
        AppHelpers.showLongToast(loginResponse.message!);
      }
    }, onError: (error) {
      AppHelpers.showLongToast(AppConstants.stNetworkError);
      print("callLoginAPI error $error");
    });
  }

  initFCMToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      _LoginController.stFCMToken=value;
      print("FirebaseMessaging token is $value");
    });
  }
}
