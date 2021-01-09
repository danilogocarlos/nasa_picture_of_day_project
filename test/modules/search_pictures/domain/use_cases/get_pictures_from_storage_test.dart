import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/errors/errors.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/repositories/search_pictures_repository.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/usecases/get_pictures_from_storage.dart';

class SearchPicturesRepositoryMock extends Mock
    implements SearchPicturesRepository {}

main() {
  final repository = SearchPicturesRepositoryMock();
  final usecase = GetPicturesFromStorageImpl(repository);

  test('Deve retornar uma lista de PicturesOfTheDay', () async {
    when(repository.getPicturesFromStorage(any))
        .thenAnswer((_) async => Right(<PictureOfTheDay>[]));

    final result = await usecase.call(null);
    expect(result | null, isA<List<PictureOfTheDay>>());
  });

  test('Deve retornar um erro caso os parâmetros de data não sejam válidos',
      () async {
    when(repository.getPicturesFromStorage(any))
        .thenAnswer((_) async => Right(<PictureOfTheDay>[]));

    final result = await usecase('1990-14-12');
    expect(
        result.fold(id, id), isA<GetPicturesToStorageErrorParamettersError>());
  });
}
