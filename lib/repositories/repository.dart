class MainRepository {
  String apiKey = "";
  static String mainApi = "https://localhost:44305/api";
  String postLogin = '$mainApi/user/login';
  String logout = '$mainApi/user/logout';
  String postTransaction = '$mainApi/transaction/';
}
