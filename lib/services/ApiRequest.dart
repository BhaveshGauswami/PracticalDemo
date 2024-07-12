import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class ApiRequest {
  final String path;
  var data;
  String methoud;
  var response;
  bool withLoading;
  var context;
  String stToken;

  ApiRequest(
      {required this.path,
      this.data,
      required this.methoud,
      this.withLoading = true,
      required this.context,
      this.stToken=""});

  Dio _dio() {
    print("token $stToken");
    // Put your authorization token here
    return Dio(
      BaseOptions(
        headers: {
          /* 'Authorization': _myAppController.userData != null
              ? 'Bearer ${_myAppController.userData['token']}'
              : '',*/
          'Authorization':stToken,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  void request({
    required Function(dynamic data, dynamic response) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    if (await AppHelpers.checkInternetorWIFI()) {
      // start request time
      DateTime startTime = DateTime.now();

      try {
        // show  request detils in debug console
        showRequestDetails(
          methoud: methoud,
          path: this.path,
          body: this.data.toString(),
        );
        // strat spinnet loading
        if (withLoading) startLoading();
        // check methoud type
        switch (methoud) {
          case AppConstants.GET_METHOUD:
            response = await _dio().get(AppConstants.stBaseURL + this.path,
                queryParameters: this.data);

            break;
          case AppConstants.POST_METHOUD:
            response = await _dio()
                .post(AppConstants.stBaseURL + this.path, data: this.data);
            break;
          case AppConstants.PUT_METHOUD:
            response = await _dio()
                .put(AppConstants.stBaseURL + this.path, data: this.data);
            break;
        }
        // request time
        var time = DateTime.now().difference(startTime).inMilliseconds;
        // print response data in console
        printSuccessesResponse(response: response.data, time: time);
        if (onSuccess != null) {
          onSuccess(response.data['data'], response.data);
        }
        if (withLoading) dismissLoading();
      } catch (error) {
        print('catch error $error');
        var time = DateTime.now().difference(startTime).inMilliseconds;

        if (error is DioError) {
          var errorResponse = error.response;
          print('errorResponse $errorResponse');
          var errorData = errorResponse != null
              ? errorResponse.data['status']
              : {"message": "Un handeled Error"};
          printRequestError(error: errorData, time: time);

          if (onError != null) {
            onError(errorData);
          }
        } else {
          // handle another errors
          print('\x1B[31m **** Request catch another error ****');
          print('\x1B[33m Error>> $error');
          print('\x1B[31m ***************************');
        }
        if (withLoading) dismissLoading();
      }
    } else {
      AppHelpers.showLongToast(AppConstants.stNoInternet);
    }
  }

  /// print request error in debug console
  printRequestError({error, time}) {
    print('🛑 \x1B[31m ******** Request Error ********* 🛑');
    print('\x1B[35m Time : \x1B[37m $time  \x1B[33m milliseconds');
    print('\x1B[35m Response :\x1B[37m $error');
    print(' \x1B[31m ************* END ************** ');
  }

  /// print successes response in debug console
  printSuccessesResponse({response, time}) {
    print('📗\x1B[32m ******** Successe Request **********📗');
    print('\x1B[35m Time : \x1B[37m $time  \x1B[33m milliseconds');
    print('\x1B[35m Response :\x1B[37m $response');
    print('\x1B[32m  *************** END **************');
  }

  /// print request details
  showRequestDetails({
    methoud,
    path,
    body,
  }) {
    print('📘\x1B[36m ******** Request Details **********📘');
    print('\x1B[35m Full URL: \x1B[37m ${AppConstants.stBaseURL}$path');
    print('\x1B[35m Methoud: \x1B[37m $methoud');
    print('\x1B[35m Path: \x1B[37m $path');
    print('\x1B[35m Body: \x1B[37m $body');
    print('\x1B[36m  *************** END **************');
  }

  // stop loading spinner
  dismissLoading() {
    print('dismissLoading');
    Get.back();
  }

  /// start loading spinner
  startLoading() {
    showDialog(
        context: context,
        builder: (_) => SpinKitRipple(
              color: Colors.white,
              size: 70.0,
            ));
  }
}
