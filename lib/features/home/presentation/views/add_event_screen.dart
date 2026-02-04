import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_dialogs.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/constatnt/constants.dart';
import 'package:evently/core/firebase_utils/firestore_utility.dart';
import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/widgets/categories_tab_bar.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:evently/core/widgets/evently_button.dart';
import 'package:evently/features/auth/data/model/user_model.dart';

import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDM selectedCategory = AppConstants.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          title: Text("Add Event", style: AppTextStyles.black16Medium),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
    text: "Add Event",
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
        id: "",
        ownerId: UserModel.currentUser!.id,
        categoryDM: selectedCategory,
        dateTime: selectedDate,
        title: titleController.text,
        description: descriptionController.text,
      );
      await createEventInFirestore(eventDM);
      Navigator.pop(context); //hide loading
      Navigator.pop(context); //go back to navigation screen
    },
  );
}
