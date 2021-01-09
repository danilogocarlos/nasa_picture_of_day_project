import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/datasources/search_pictures_datasource.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/models/picture_of_the_day_model.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/repositories/search_pictures_repository_impl.dart';

class SearchPictureDataSourceMock extends Mock
    implements SearchPicturesDatasource {}

main() {
  final datasource = SearchPictureDataSourceMock();
  final repository = SearchPictureRepositoryImpl(datasource);

  test('Deve retornar uma lista de PicturesOfTheDay', () async {
    when(datasource.searchPictures(any))
        .thenAnswer((_) async => <PictureOfTheDayModel>[]);

    final result = await repository.searchPicture(null);
    expect(result | null, isA<List<PictureOfTheDay>>());
  });

  test('Deve retornar um erro se a consulta falhar', () async {
    when(datasource.searchPictures(any)).thenThrow(Exception());

    final result = await repository.searchPicture(null);
    expect(result.fold(id, id), isA<SearchPictureRequestError>());
  });

  test('Deve retornar uma lista de PicturesOfTheDay', () async {
    final result = await repository.getPicturesFromStorage(null);
    expect(result | null, isA<List<PictureOfTheDay>>());
  });

  // test('Deve retornar um erro se a consulta falhar', () async {
  //   when(GetStorage().read(any)).thenThrow(Exception());
  //   final result = await repository.getPicturesFromStorage(null);
  //   expect(result.fold(id, id), isA<GetPicturesToStorageRequestError>());
  // });
}
