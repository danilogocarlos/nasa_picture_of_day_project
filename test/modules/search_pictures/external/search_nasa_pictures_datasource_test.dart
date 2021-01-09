import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/external/search_nasa_pictures_datasource.dart';

import '../utils/nasa_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = SearchNasaPicturesDatasource(dio);

  test('Deve retornar uma lista de PictureOfTheDayModel', () async {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(nasaSearchPicturesResponse),
        statusCode: 200,
      ),
    );

    final future = datasource.searchPictures(null);
    expect(future, completes);
  });

  test(
      'Deve retornar SearchPictureRequestError se o statusCode não for entre 200 a 299',
      () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.searchPictures(null);
    expect(future, throwsA(isA<SearchPictureRequestError>()));
  });

  test('Deve retornar um Exception se houver algum erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.searchPictures(null);
    expect(future, throwsA(isA<Exception>()));
  });
}
