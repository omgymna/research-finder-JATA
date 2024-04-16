// signup url= '13.53.175.251:4457/api/faculty/signup_faculty'

class APIs{

  static const String baseUrl = 'http://13.53.175.251:4457/api';
  static const String filesBaseUrl = 'https://research-finder-dev-bucket.s3.eu-north-1.amazonaws.com';

  //App APIs
  static const String appBaseUrl = '$baseUrl/app_api';
  static const String loginApi = '$appBaseUrl/login';
  static const String passwordApi = '$appBaseUrl/update_password';

  //Faculty APIs
  static const String facultyBaseUrl = '$baseUrl/faculty';
  static const String facultySignupApi = '$facultyBaseUrl/signup_faculty';
  static const String facultyUpdateApi = '$facultyBaseUrl/update_profile';
  static const String facultyProfileApi = '$facultyBaseUrl/profile';
  static const String facultyDeleteApi = '$facultyBaseUrl/delete_faculty';
  static const String facultyListApi = '$facultyBaseUrl/list';
  static const String facultyCoursesApi = '$baseUrl/course/my_courses';

  //Student APIs
  static const String studentBaseUrl = '$baseUrl/student';
  static const String studentSignupApi = '$studentBaseUrl/signup_student';
  static const String studentUpdateApi = '$studentBaseUrl/update_profile';
  static const String studentProfileApi = '$studentBaseUrl/profile';
  static const String studentDeleteApi = '$studentBaseUrl/delete_student';
  static const String studentListApi = '$studentBaseUrl/all_students_list';

  //Course APIs
  static const String courseBaseUrl = '$baseUrl/course';
  static const String courseAddApi = '$courseBaseUrl/add_course';
  static const String courseEditApi = '$courseBaseUrl/update_course';
  static const String courseDetailsApi = '$courseBaseUrl/course_details';
  static const String facultyCoursesForStudentsApi = '$courseBaseUrl/faculty_courses';
  static const String deleteCourseApi = '$courseBaseUrl/delete_course';

  //Chat Room APIs
  static const String chatRoomBaseUrl = '$baseUrl/chat_room';
  static const String addChatRoomApi = '$chatRoomBaseUrl/add_chat_room';
  static const String userChatRoomsApi = '$chatRoomBaseUrl/user_chat_rooms';

}
