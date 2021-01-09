import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/usecases/get_pictures_from_storage.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/usecases/search_pictures.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/external/search_nasa_pictures_datasource.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/infra/repositories/search_pictures_repository_impl.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/presenter/search_pictures_controller.dart';

class SearchPicturesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio());
    Get.lazyPut<SearchPicturesImpl>(
      () => SearchPicturesImpl(
        SearchPictureRepositoryImpl(
          SearchNasaPicturesDatasource(
            Get.find<Dio>(),
          ),
        ),
      ),
    );
    Get.lazyPut<GetPicturesFromStorageImpl>(
      () => GetPicturesFromStorageImpl(
        SearchPictureRepositoryImpl(
          SearchNasaPicturesDatasource(
            Get.find<Dio>(),
          ),
        ),
      ),
    );
    Get.lazyPut<SearchPicturesController>(() => SearchPicturesController());
  }
}
