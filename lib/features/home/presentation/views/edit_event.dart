import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_dialogs.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/constatnt/constants.dart';
import 'package:evently/core/firebase_utils/firestore_utility.dart';
import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/widgets/categories_tab_bar.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:evently/core/widgets/evently_button.dart';

import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  final EventDM event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  CategoryDM selectedCategory = AppConstants.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.title;
    descriptionController.text = widget.event.description;
    selectedDate = widget.event.dateTime;
    selectedTime = TimeOfDay.fromDateTime(widget.event.dateTime);
    selectedCategory = widget.event.categoryDM;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          title: Text("Edit Event", style: AppTextStyles.black16Medium),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: () async {
                await deleteEventFromFirestore(widget.event);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        selectedCategory.imagePath,
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      SizedBox(height: 16),
                      CategoriesTabBar(
                        categories: AppConstants.customCategories,
                        onChanged: (selectedCategory) {
                          this.selectedCategory = selectedCategory;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Title",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.black16Medium,
                      ),
                      SizedBox(height: 8),
                      CustomeTextField(
                        null,
                        text: 'Event Title',
                        isPassword: false,
                        controller: titleController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.black16Medium,
                      ),
                      SizedBox(height: 8),
                      CustomeTextField(
                        null,
                        text: 'Event Description',
                        isPassword: false,
                        controller: descriptionController,
                      ),
                      SizedBox(height: 16),
                      buildChooseDateRow(),
                      SizedBox(height: 16),
                      buildChooseTimeRow(),
                    ],
                  ),
                ),
              ),
              buildAddEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildChooseDateRow() => Row(
    children: [
      Icon(Icons.calendar_month, size: 24, color: AppColors.blue),
      SizedBox(width: 8),
      Text("Event Date", style: AppTextStyles.black16Medium),
      Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
      Spacer(),
      InkWell(
        onTap: () async {
          selectedDate =
              await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
                initialDate: selectedDate,
              ) ??
              selectedDate;
          setState(() {});
        },
        child: Text(
          "Choose Date",
          style: AppTextStyles.blue14Regular.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  buildChooseTimeRow() => Row(
    children: [
      Icon(Icons.access_time, size: 24, color: AppColors.blue),
      SizedBox(width: 8),
      Text("Event Time", style: AppTextStyles.black16Medium),
      Text(" ${selectedTime.hour}:${selectedTime.minute}"),
      Spacer(),
      InkWell(
        onTap: () async {
          selectedTime =
              await showTimePicker(
                context: context,
                initialTime: selectedTime,
              ) ??
              selectedTime;
          setState(() {});
        },
        child: Text(
          "Choose Time",
          style: AppTextStyles.blue14Regular.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  buildAddEventButton() => EventlyButton(
    text: "Update Event",
    onPress: () async {
      showLoading(context);

      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      EventDM eventDM = EventDM(
        id: widget.event.id,
        ownerId: widget.event.ownerId,
        categoryDM: selectedCategory,
        dateTime: selectedDate,
        title: titleController.text,
        description: descriptionController.text,
      );
      await updateEventInFirestore(eventDM);
      Navigator.pop(context); //hide loading
      Navigator.pop(context); //go back to navigation screen
    },
  );
}
