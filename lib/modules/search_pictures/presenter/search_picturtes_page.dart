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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RaisedButton(
            onPressed: () => buildMaterialDatePicker(context),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () => SearchPicturesController.to.clearFilters(),
            child: Row(
              children: [
                Icon(Icons.cleaning_services_outlined),
                SizedBox(width: 10),
                Text(
                  'Clear filters',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemCount: controller.filteredListOfPictures.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Card(
            color: Colors.white,
            child: Obx(
              () {
                return ListTile(
                  onTap: () =>
                      Get.to(ShowPicturePage(controller.listOfPictures[index])),
                  dense: true,
                  trailing: Icon(Icons.chevron_right),
                  title: Text(controller.filteredListOfPictures[index].title),
                  subtitle: Text(controller.filteredListOfPictures[index].date),
                );
              },
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
      SearchPicturesController.to.selectedDate = selectedDate;
      SearchPicturesController.to.searchPicturesByDate();
    }
  }
}
