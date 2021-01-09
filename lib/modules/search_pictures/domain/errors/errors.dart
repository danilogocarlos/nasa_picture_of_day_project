abstract class SearchPicturesError implements Exception {}

class InvalidDateParamettersError implements SearchPicturesError {}

class SearchPictureRequestError implements SearchPicturesError {
  final String message;
  SearchPictureRequestError({this.message});
}

abstract class GetPicturesToStorageError implements Exception {}

class GetPicturesToStorageErrorParamettersError
    implements GetPicturesToStorageError {}

class GetPicturesToStorageRequestError implements GetPicturesToStorageError {}
