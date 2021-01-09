import 'package:dartz/dartz.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';

abstract class SearchPicturesRepository {
  Future<Either<SearchPicturesError, List<PictureOfTheDay>>> searchPicture(
      String date);

  Future<Either<GetPicturesToStorageError, List<PictureOfTheDay>>>
      getPicturesFromStorage(String date);
}
