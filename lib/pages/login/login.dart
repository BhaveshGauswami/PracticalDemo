import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
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
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    initFCMToken();
    initPlatformState();
    initUniqueIdentifierState();
    _getCurrentPosition();
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

  callLoginAPI(var params) {
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
                builder: (context) => DashboardPage(
                      stUserImagePath: loginResponse.data![0].userprofilephoto!,
                      stUserName: loginResponse.data![0].userfirstname!,
                      stLoginToken: loginResponse.data![0].token!,
                      stUserId: loginResponse.data![0].userId!,
                    )),
            (route) => false);
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
      _LoginController.stFCMToken = value;
      print("FirebaseMessaging token is $value");
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    print("latitude ${position.latitude}");
    print("longitude ${position.longitude}");
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }
    return true;
  }
}
