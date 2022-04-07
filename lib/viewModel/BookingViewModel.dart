import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/model/repositories/BookingRepo.dart';
import 'package:flutter/cupertino.dart';

class BookingViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  BookingModel? _bookingModel;

  ApiResponse get response {
    return _apiResponse;
  }

  BookingModel? get bookingModel {
    return _bookingModel;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      List<BookingModel> mediaList = await BookingRepo().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(BookingModel? bookingModel) {
    _bookingModel = bookingModel;
    notifyListeners();
  }
}