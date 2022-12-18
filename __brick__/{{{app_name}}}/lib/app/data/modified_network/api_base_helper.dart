import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:{{{app_name.snakeCase()}}}/app/data/modified_network/api_response.dart';
import 'package:{{{app_name.snakeCase()}}}/app/data/network/api_config.dart';
import 'package:{{{app_name.snakeCase()}}}/app/data/network/api_msg_strings.dart';
import 'package:{{{app_name.snakeCase()}}}/app/data/network/app_exception.dart';
import 'package:{{{app_name.snakeCase()}}}/app/data/network/connectivity.dart';
import 'package:{{{app_name.snakeCase()}}}/app/utils/debug_utils/debug_utils.dart';

class ApiBaseHelper {

  ApiBaseHelper._internal();

  factory ApiBaseHelper.getInstance() {
    _instance ??= ApiBaseHelper._internal();
    return _instance!;
  }
  static const String _baseUrl = ApiConfig.baseUrl;

  static ApiBaseHelper? _instance;

  // ApiHeaders:--------------------------------get/set api headers---------------------------------------
  Map<String, String> getApiHeaders(Map<String, String>? authToken) {
    final map = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
    }..addEntries(authToken!.entries);
    return map;
  }

  //Image/Video upload header---------------------------------------------------
  Map<String, String>? uploadHeader({String? type}) {
    final map = <String, String>{
      'Content-Type': 'application',};

    return map;
  }

/*
  Map<String, String> getApiHeaders(String? authToken) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
      'Authorization': 'Bearer $authToken',
    };
  }
*/

// Get:--------------------------------get api call with query params---------------------------------------
  Future<ApiResponse<dynamic>?> getApiCallWithQuery(
      String url, Map<String, String> queryParameters,) async {
    var uri = Uri.parse(_baseUrl + url);
    uri = uri.replace(queryParameters: queryParameters);
    final headers = await getHeadersValues();
    if (kDebugMode) dev.log('Api Get with params, url $uri');
    final response = await safeApiCall(http.get(
      uri,
      headers: headers,
    ),);
    return response;
  }

// Get:-----------------------------------------------------------------------
  Future<ApiResponse<dynamic>?> get(String url) async {
    if (kDebugMode) dev.log('Api Get, url $url');
    final headers = await getHeadersValues();
    final response = await safeApiCall(http.get(
      Uri.parse(_baseUrl + url),
      headers: headers,
    ));
    return response;
  }

// Post:-----------------------------------------------------------------------
  Future<ApiResponse<dynamic>?> post(String url, Map<String, dynamic> jsonData) async {
    final headers = await getHeadersValues();
    if (kDebugMode) {
      print('Api Post, url $_baseUrl$url');
      dev.log('Api request- ${jsonEncode(jsonData)}');
      print('Api headers- $headers');
    }
    final response = safeApiCall(http.post(Uri.parse(_baseUrl + url),
        headers: headers,
        body: jsonData.isNotEmpty ? jsonEncode(jsonData) : null, ),);
    return response;
  }

// Put:-----------------------------------------------------------------------
  Future<ApiResponse<dynamic>?> put(
      String url, Uint8List uint8list, String? type) async {
    if (kDebugMode) dev.log('Api Put, url $url');
    if (kDebugMode) dev.log('Api request- ${jsonEncode(uint8list)}');
    final headers = uploadHeader(type: type);
    final response = safeApiCall(
        http.put(Uri.parse(url), headers: headers, body: uint8list));
    return response;
  }

// Delete:------------------------------------------------------
  Future<ApiResponse<dynamic>?> delete(String url) async {
    if (kDebugMode) dev.log('Api delete, url $url');
    final headers = await getHeadersValues();
    final response = safeApiCall(http.delete(
      Uri.parse(_baseUrl + url),
      headers: headers,
    ));
    return response;
  }

// Post multipart file to server with json data:----------------------
  Future<ApiResponse<dynamic>?> postApiCallMultipart(
      String url, Map<String, dynamic> jsonData, File file,
      {String? multiPartParameterName,}) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url));
    final headers = await getHeadersValues();
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        multiPartParameterName ?? 'file',
        http.ByteStream(Stream.castFrom(file.openRead())),
        await file.length(),
        filename: file.path.split('/').last,
      ),
    );
    final response = safeApiCall(http.Response.fromStream(await request.send()));
    return response;
  }

  /*----------------------------Get_Hearders_Values----------------------*/

  Future<Map<String, String>> getHeadersValues() async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
      // 'Authorization': ApiConfig.apiKey,
    };

    // show headers
    DebugUtils.showLog(DateTime.now().timeZoneOffset.inSeconds.toString(),
        prefix: 'UtcOffsetInSecond > ',);

    return Future.value(headers);
  }

// SafeApiCall:--------------------------------safe api call---------------------------------------
  Future<ApiResponse<dynamic>?> safeApiCall(Future<http.Response> apiResponse) async {
    if (await ConnectionStatus.getInstance().checkConnection()) {
      try {
        final response = await apiResponse.timeout(const Duration(seconds: 60));
        return ApiResponse.success(_returnResponse(response));
      } on BadRequestException {
        return ApiResponse.error(ApiMsgStrings.txtInvalidRequest);
      } on UnauthorisedException {
        return ApiResponse.error(ApiMsgStrings.txtUnauthorised);
      } on FetchDataException {
        return ApiResponse.error(ApiMsgStrings.txtSomethingWentWrong);
      } on TimeoutException {
        return ApiResponse.error(ApiMsgStrings.txtConnectionTimeOut);
      } on SocketException {
        return ApiResponse.error(ApiMsgStrings.txtNoInternetConnection);
      } catch (e) {
        return ApiResponse.error(e.toString());
      }
    } else {
      return ApiResponse.error(ApiMsgStrings.txtNoInternetConnection);
    }
  }
}

dynamic _returnResponse(http.Response response) {
  if (kDebugMode) {
    log('hereResCode> ${response.statusCode} ');
  }
  switch (response.statusCode) {
    case 200:
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      if (kDebugMode) {
        DebugUtils.showLog(responseJson.toString(), prefix: 'Here Res  >> ');
      }
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          '${ApiMsgStrings.txtServerError} ${response.statusCode}');
  }
}
