import 'package:dartz/dartz.dart';

import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/repositories/search_pictures_repository.dart';

abstract class GetPicturesFromStorage {
  Future<Either<GetPicturesToStorageError, List<PictureOfTheDay>>> call(
      String date);
}

class GetPicturesFromStorageImpl implements GetPicturesFromStorage {
  final SearchPicturesRepository repository;
  GetPicturesFromStorageImpl(this.repository);

  @override
  Future<Either<GetPicturesToStorageError, List<PictureOfTheDay>>> call(
      String date) async {
    if (date != null && !isDateValid(date))
      return Left(GetPicturesToStorageErrorParamettersError());

    return repository.getPicturesFromStorage(date);
  }

  bool isDateValid(String date) {
    return RegExp(r'^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$')
        .hasMatch(date);
  }
}
