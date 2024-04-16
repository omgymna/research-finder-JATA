abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url , dynamic data);

  Future<dynamic> getUpdateApiResponse(String url , dynamic data);

  Future<dynamic> getDeleteCourseApiResponse(String id);

  Future<dynamic> getFacultySignupApiResponse(String url , dynamic data);

  Future<dynamic> getStudentSignupApiResponse(String url , dynamic data);

  Future<dynamic> getCourseUploadApiResponse(String url , dynamic data);

  Future<dynamic> getFetchMyCoursesApiResponse();

  Future<dynamic> getFacultyCoursesApiResponse(String id);

}
