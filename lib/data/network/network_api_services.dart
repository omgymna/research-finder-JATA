import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../api.dart';
import '../../main.dart';
import '../../prefs.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService implements BaseApiServices {

  @override
  Future getGetApiResponse(String url) async {
    debugPrint(url);
    dynamic responseJson ;
    try {
      String token = '';
      await Prefs.getToken().then((value){
        if(value != null){
          token = value;
        }
      });
      final response = await http.get(Uri.parse(url), headers: {
        'x-auth-token': token,
      },).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    debugPrint(responseJson.toString());
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    debugPrint('data: $data');
    dynamic responseJson ;
    try {
      Response response = await post(
          Uri.parse(url),
          body: data,
        headers: {
          'x-auth-token' : token ?? ''
        }
      ).timeout( const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('No Internet Connection');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson ;
  }

  @override
  Future getUpdateApiResponse(String url, data) async {
    debugPrint('data: $data');
    dynamic responseJson ;
    try {
      Response response = await put(
          Uri.parse(url),
          body: data,
          headers: {
            'x-auth-token' : token ?? ''
          }
      ).timeout( const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('No Internet Connection');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson ;
  }

  @override
  Future getFacultySignupApiResponse(String url, dynamic data) async{
    dynamic responseJson ;
    try{
      var stream  = http.ByteStream(File(data['image']).openRead());
      stream.cast();
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      var mpFile = await http.MultipartFile.fromPath(
          'image',
          data['image'],
          filename: 'profile.jpg'
      );
      request.fields['name'] = data['name'];
      request.fields['email'] = data['email'];
      request.fields['password'] = data['password'];
      request.fields['confirm_password'] = data['confirm_password'];
      request.fields['university'] = data['university'];
      request.files.add(mpFile);
      var response = await request.send();
      Response res = await convertStreamedResponseToHttpResponse(response);
      responseJson = returnResponse(res);
      // if (response.statusCode == 200) {
      //   var responseData = await response.stream.transform(utf8.decoder).join();
      //   var jsonResponse = jsonDecode(responseData);
      //   var z = jsonResponse['faculty'];
      //   responseJson = z;
      //   // response.stream.transform(utf8.decoder).listen((value) {
      //   //   var x = jsonDecode(value);
      //   //   var z = x['faculty'];
      //   //   responseJson = z;
      //   // });
      // } else {
      //   debugPrint('Request failed with status: ${response.statusCode}.');
      //   response.stream.transform(utf8.decoder).listen((value) {
      //     debugPrint('type: ${value.runtimeType.toString()}');
      //     // var x = jsonDecode(value);
      //     // debugPrint(x['faculty']);
      //   });
      // }
    }on SocketException {
      throw NoInternetException('No Internet Connection');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;
  }

  @override
  Future getStudentSignupApiResponse(String url, dynamic data) async{
    dynamic responseJson ;
    try{
      var stream  = http.ByteStream(File(data['image']).openRead());
      stream.cast();
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      var mpFile = await http.MultipartFile.fromPath(
          'image',
          data['image'],
          filename: 'profile.jpg'
      );
      request.fields['name'] = data['name'];
      request.fields['email'] = data['email'];
      request.fields['password'] = data['password'];
      request.fields['confirm_password'] = data['confirm_password'];
      request.fields['university'] = data['university'];
      request.files.add(mpFile);
      var response = await request.send();
      Response res = await convertStreamedResponseToHttpResponse(response);
      responseJson = returnResponse(res);
      // if (response.statusCode == 200) {
      //   var responseData = await response.stream.transform(utf8.decoder).join();
      //   var jsonResponse = jsonDecode(responseData);
      //   var z = jsonResponse['student'];
      //   responseJson = z;
      //   // response.stream.transform(utf8.decoder).listen((value) {
      //   //   var x = jsonDecode(value);
      //   //   var z = x['faculty'];
      //   //   responseJson = z;
      //   // });
      // } else {
      //   debugPrint('Request failed with status: ${response.statusCode}.');
      //   response.stream.transform(utf8.decoder).listen((value) {
      //     debugPrint('type: ${value.runtimeType.toString()}');
      //     // var x = jsonDecode(value);
      //     // debugPrint(x['faculty']);
      //   });
      // }
    }on SocketException {
      throw NoInternetException('No Internet Connection');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;
  }

  @override
  Future getCourseUploadApiResponse(String url, data) async {
    dynamic responseJson;
    try{
      var stream  = http.ByteStream(File(data['file']).openRead());
      stream.cast();
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      var mpFile = await http.MultipartFile.fromPath(
          'file',
          data['file'],
          filename: 'file.pdf'
      );
      request.fields['name'] = data['name'];
      request.fields['description'] = data['description'];
      request.files.add(mpFile);
      request.headers['x-auth-token'] = token ?? '';
      var response = await request.send();
      Response res = await convertStreamedResponseToHttpResponse(response);
      responseJson = returnResponse(res);
    }on SocketException {
      throw NoInternetException('No Internet Connection');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;
  }

  @override
  Future getFetchMyCoursesApiResponse() async{
    dynamic responseJson ;
    try{
      String token = '';
      await Prefs.getToken().then((value){
        if(value != null){
          token = value;
        }
      });
      final response = await http.get(
          Uri.parse(APIs.facultyCoursesApi),
        headers: {
          'x-auth-token': token,
        },
      ).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;
  }

  @override
  Future getFacultyCoursesApiResponse(String id) async{
    dynamic responseJson ;
    try{
      String token = '';
      await Prefs.getToken().then((value){
        if(value != null){
          token = value;
        }
      });
      final response = await http.get(
        Uri.parse('${APIs.facultyCoursesForStudentsApi}/$id'),
        headers: {
          'x-auth-token': token,
        },
      ).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;
  }

  @override
  Future getDeleteCourseApiResponse(String id) async {
    dynamic responseJson;
    try{
      String token = '';
      await Prefs.getToken().then((value){
        if(value != null){
          token = value;
        }
      });
      final response = await http.delete(
        Uri.parse('${APIs.deleteCourseApi}/$id'),
        headers: {
          'x-auth-token': token,
        },
      ).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    }on SocketException {
      throw NoInternetException('');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    return responseJson;

  }

  dynamic returnResponse (http.Response response){
    debugPrint(response.statusCode.toString());
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occurred while communicating with server');
    }
  }

  Future<http.Response> convertStreamedResponseToHttpResponse(http.StreamedResponse streamedResponse) async {
    Uint8List bytes = await streamedResponse.stream.toBytes();
    String body = utf8.decode(bytes);
    http.Response httpResponse = http.Response(
      body,
      streamedResponse.statusCode,
      headers: streamedResponse.headers,
      isRedirect: streamedResponse.isRedirect,
      persistentConnection: streamedResponse.persistentConnection,
      reasonPhrase: streamedResponse.reasonPhrase,
      request: streamedResponse.request,
    );
    return httpResponse;
  }

}
