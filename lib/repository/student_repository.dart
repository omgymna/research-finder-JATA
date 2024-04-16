import '../api.dart';
import '../data/network/network_api_services.dart';

class StudentRepository{

  final _apiService  = NetworkApiService();

  Future<dynamic> studentListApi() async{
    dynamic response = await _apiService.getGetApiResponse(APIs.studentListApi);
    return response ;
  }

}
