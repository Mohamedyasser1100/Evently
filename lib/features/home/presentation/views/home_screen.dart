import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/constatnt/constants.dart';
import 'package:evently/core/firebase_utils/firestore_utility.dart';
import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/widgets/categories_tab_bar.dart';
import 'package:evently/core/widgets/event_widget.dart';
import 'package:evently/features/auth/data/model/user_model.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EventDM> events = [];
  List<EventDM> filteredEvents = [];
  var selectedCategory = AppConstants.allCategories[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          buildHeader(),
          StreamBuilder(
            stream: getEventsFromFirestore(),
            builder: (context, snapshot) {
              print("snapshot.connectionState = ${snapshot.connectionState}");
              print("snapshot.data = ${snapshot.data}");
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                events = snapshot.data!;
                filterEvents();
                return Expanded(
                  child: Column(
                    children: [
                      buildCategoriesTabBar(),
                      SizedBox(height: 16),
                      buildEventsList(),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back ✨", style: AppTextStyles.grey14Regular),
                SizedBox(height: 8),
                Text(
                  UserModel.currentUser!.name,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.black20SemiBold,
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.brightness_5, color: AppColors.blue, size: 24),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "En",
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  buildCategoriesTabBar() {
    return CategoriesTabBar(
      categories: AppConstants.allCategories,
      onChanged: (category) {
        selectedCategory = category;
        setState(() {});
      },
    );
  }

  void filterEvents() {
    if (selectedCategory != AppConstants.all) {
      filteredEvents = events.where((event) {
        return event.categoryDM.name == selectedCategory.name;
      }).toList();
      print(filteredEvents);
    } else {
      filteredEvents = events;
    }
  }

  buildEventsList() {
    print("buildEventsList: ${filteredEvents}");
    return Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return EventWidget(eventDM: filteredEvents[index]);
        },
      ),
    );
  }
}
