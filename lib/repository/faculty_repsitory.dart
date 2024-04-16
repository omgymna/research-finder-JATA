import '../api.dart';
import '../data/network/network_api_services.dart';

class FacultyRepository{

  final _apiService  = NetworkApiService();

  Future<dynamic> facultyListApi() async{
    dynamic response = await _apiService.getGetApiResponse(APIs.facultyListApi);
    return response ;
  }

}
