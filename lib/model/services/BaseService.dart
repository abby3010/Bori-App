abstract class BaseService {
  final String BaseUrl = "https://itunes.apple.com/search?term=";

  Future<dynamic> getResponse(String url);

}