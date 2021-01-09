import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/repositories/search_pictures_repository.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/datasources/search_pictures_datasource.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/models/picture_of_the_day_model.dart';

class SearchPictureRepositoryImpl implements SearchPicturesRepository {
  final SearchPicturesDatasource datasource;
  SearchPictureRepositoryImpl(this.datasource);

  @override
  Future<Either<SearchPicturesError, List<PictureOfTheDay>>> searchPicture(
      String date) async {
    try {
      final result = await datasource.searchPictures(date);

      final box = GetStorage();
      box.write('listOfPictures', jsonEncode(result));

      return Right(result);
    } catch (e) {
      return Left(SearchPictureRequestError());
    }
  }

  @override
  Future<Either<GetPicturesToStorageError, List<PictureOfTheDay>>>
      getPicturesFromStorage(String date) async {
    try {
      final box = GetStorage();

      String result = await box.read('listOfPictures');

      var list = List<PictureOfTheDayModel>();

      List.from(json.decode(result)).forEach((element) {
        if (date != null && '$date' == '${json.decode(element)['date']}') {
          list.add(PictureOfTheDayModel.fromJson(element));
        } else if (date == null) {
          list.add(PictureOfTheDayModel.fromJson(element));
        }
      });

      print(list);

      return Right(list);
    } catch (e) {
      return Left(GetPicturesToStorageRequestError());
    }
  }
}
