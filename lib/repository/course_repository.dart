import '../data/network/network_api_services.dart';

class CourseRepository{

  final _apiService  = NetworkApiService() ;

  Future<dynamic> courseUploadApi(String url, var data) async{
    dynamic response = await _apiService.getCourseUploadApiResponse(url, data);
    return response;
  }

  Future<dynamic> fetchMyCoursesApi() async{
    dynamic response = await _apiService.getFetchMyCoursesApiResponse();
    return response;
  }

  Future<dynamic> fetchFacultyCoursesApi(String id) async{
    dynamic response = await _apiService.getFacultyCoursesApiResponse(id);
    return response;
  }

  Future<dynamic> courseDeleteApi(String id) async{
    dynamic response = await _apiService.getDeleteCourseApiResponse(id);
    return response;
  }

}
