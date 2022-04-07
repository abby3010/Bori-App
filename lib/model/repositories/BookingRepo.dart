import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/services/BaseService.dart';
import 'package:bori_app/model/services/BookingService.dart';

class BookingRepo {
  BaseService baseService = BookingService();

  Future<List<BookingModel>> fetchMediaList(String value) async {
    dynamic response = await baseService.getResponse(value);
    final jsonData = response['results'] as List;
    List<BookingModel> mediaList =
    jsonData.map((tagJson) => BookingModel.fromJson(tagJson)).toList();
    return mediaList;
  }
}