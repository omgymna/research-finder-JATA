import '../data/network/network_api_services.dart';

class ProfileRepository{

  final _apiService  = NetworkApiService() ;

  Future<dynamic> facultyUpdateApi(String url, var data) async{
    dynamic response = await _apiService.getUpdateApiResponse(url, data);
    return response;
  }

  Future<dynamic> studentUpdateApi(String url, var data) async{
    dynamic response = await _apiService.getUpdateApiResponse(url, data);
    return response;
  }

}
