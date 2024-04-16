import '../api.dart';
import '../data/network/network_api_services.dart';

class AuthRepository{

  final _apiService  = NetworkApiService() ;

  Future<dynamic> loginApi(var data) async{
    dynamic response = await _apiService.getPostApiResponse(APIs.loginApi, data);
    return response ;
  }

  Future<dynamic> facultySignupApi(String url, var data) async{
    dynamic response = await _apiService.getFacultySignupApiResponse(url, data);
    return response;
  }

  Future<dynamic> studentSignupApi(String url, var data) async{
    dynamic response = await _apiService.getStudentSignupApiResponse(url, data);
    return response;
  }

}
