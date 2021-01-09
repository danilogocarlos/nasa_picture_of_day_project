import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/datasources/search_pictures_datasource.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/models/picture_of_the_day_model.dart';

class SearchNasaPicturesDatasource implements SearchPicturesDatasource {
  final Dio dio;

  SearchNasaPicturesDatasource(this.dio);

  @override
  Future<List<PictureOfTheDayModel>> searchPictures(String date) async {
    String baseUrl =
        'https://api.nasa.gov/planetary/apod?api_key=M1vtwG7W5I6fPBnrR0vgKKcnE0TIswRo4xqjSwum';
    String url = (date != null && date != '')
        ? '$baseUrl&date=$date'
        : '$baseUrl&count=100';

    final response = await dio.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var list = List<PictureOfTheDayModel>();

      if (response.data is List) {
        list = (response.data as List)
            .map((e) => PictureOfTheDayModel.fromMap(e))
            .toList();
      } else {
        list.add(PictureOfTheDayModel.fromJson(json.encode(response.data)));
      }

      return list;
    } else {
      throw SearchPictureRequestError();
    }
  }
}
