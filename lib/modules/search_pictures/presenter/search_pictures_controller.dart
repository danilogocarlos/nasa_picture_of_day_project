import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/usecases/get_pictures_from_storage.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/usecases/search_pictures.dart';

class SearchPicturesController extends GetxController {
  static SearchPicturesController get to => Get.find();
  var searchPictures = Get.find<SearchPicturesImpl>();
  var getPicturesFromStorageImpl = Get.find<GetPicturesFromStorageImpl>();
  final box = GetStorage();

  final _listOfPictures = List<PictureOfTheDay>().obs;
  set listOfPictures(value) => this._listOfPictures.assignAll(value);
  get listOfPictures => this._listOfPictures;

  final _filteredListOfPictures = List<PictureOfTheDay>().obs;
  set filteredListOfPictures(value) =>
      this._filteredListOfPictures.assignAll(value);
  get filteredListOfPictures => this._filteredListOfPictures;

  final _selectedDate = ''.obs;
  set selectedDate(value) => this._selectedDate.value = value;
  get selectedDate => this._selectedDate;

  final _isLoading = false.obs;
  set isLoading(value) => this._isLoading.value = value;
  get isLoading => this._isLoading;

  @override
  onInit() {
    fetchList();
    super.onInit();
  }

  fetchList() async {
    this._isLoading.value = true;
    await searchPictures(null).then((value) async {
      value.fold((l) => null, (r) => this._listOfPictures.assignAll(r));

      if (value is Left) {
        await getPicturesFromStorageImpl(null).then((value) =>
            value.fold((l) => null, (r) => this._listOfPictures.assignAll(r)));
      }

      this._isLoading.value = false;
      this._filteredListOfPictures.assignAll(this._listOfPictures);
    });
  }

  searchPicturesByDate() async {
    this._isLoading.value = true;
    await searchPictures(this._selectedDate.value).then((value) async {
      value.fold((l) => null, (r) => this._listOfPictures.assignAll(r));

      print(value);

      if (value is Left) {
        await getPicturesFromStorageImpl(this._selectedDate.value).then(
            (value) => value.fold(
                (l) => null, (r) => this._listOfPictures.assignAll(r)));
      }

      this._isLoading.value = false;
      this._filteredListOfPictures.assignAll(this._listOfPictures);
    });
  }

  searchPicturesByTitle(String title) {
    var result = _listOfPictures
        .where((picture) =>
            picture.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    this._filteredListOfPictures.assignAll(result);
  }

  clearFilters() {
    this._selectedDate.value = '';
    fetchList();
  }
}
