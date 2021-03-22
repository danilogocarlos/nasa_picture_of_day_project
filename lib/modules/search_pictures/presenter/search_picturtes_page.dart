import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/presenter/search_pictures_controller.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/presenter/show_picture_page.dart';

class SearchPicturesPage extends GetWidget<SearchPicturesController> {
  final textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        appBar: pageAppBar(context),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    searchTextField(),
                    Expanded(child: listOfPictures()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget pageAppBar(context) {
    return AppBar(
      title: Obx(
        () => filterButton(controller.selectedDate.value != '', context),
      ),
    );
  }

  Widget filterButton(bool isDateSelected, context) {
    return isDateSelected
        ? TextButton(
            onPressed: () => controller.clearFilters(),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.clear,
                  color: Colors.white,
                ),
              ],
            ),
          )
        : TextButton(
            onPressed: () => buildMaterialDatePicker(context),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.calendar,
                  color: Colors.white,
                ),
              ],
            ),
          );
  }

  Widget searchTextField() {
    return Obx(
      () => (controller.selectedDate.value == null ||
              controller.selectedDate.value == '')
          ? TextField(
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(labelText: "Search by title"),
              controller: textSearchController,
              onChanged: (text) =>
                  SearchPicturesController.to.searchPicturesByTitle(text),
            )
          : SizedBox.shrink(),
    );
  }

  Widget listOfPictures() {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: controller.filteredListOfPictures.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.all(5),
          child: Obx(
            () => GestureDetector(
              onTap: () =>
                  Get.to(ShowPicturePage(controller.listOfPictures[index])),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.listOfPictures[index].url,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.filteredListOfPictures[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          controller.filteredListOfPictures[index].date,
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      helpText: 'Select booking date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Select a date',
      fieldHintText: 'year/month/date',
    );
    if (picked != null) {
      String selectedDate = DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(picked.toString()))
          .toString();
      controller.selectedDate = selectedDate;
      controller.searchPicturesByDate();
    }
  }
}
