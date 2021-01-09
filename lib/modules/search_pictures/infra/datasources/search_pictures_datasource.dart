import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/models/picture_of_the_day_model.dart';

abstract class SearchPicturesDatasource {
  Future<List<PictureOfTheDayModel>> searchPictures(String date);
}
