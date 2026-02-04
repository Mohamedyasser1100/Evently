import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/firebase_utils/firestore_utility.dart';
import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventDetails extends StatelessWidget {
  final EventDM event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text("Event details", style: AppTextStyles.black16Medium),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(
                  context,
                ).push(AppRoute.editEventScreen, extra: event);
              },
              icon: Icon(Icons.edit, color: AppColors.blue),
            ),
            IconButton(
              onPressed: () async {
                await deleteEventFromFirestore(event);
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  event.categoryDM.imagePath,
                  height: MediaQuery.of(context).size.height * .25,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.title,
                textAlign: TextAlign.start,
                style: AppTextStyles.blue24SemiBold,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(153, 148, 181, 251),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.calendar_month, color: AppColors.blue),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event.dateTime.day} ${event.dateTime.month}, ${event.dateTime.year}",
                          style: AppTextStyles.blue16Medium,
                        ),
                        Text(
                          "${event.dateTime.hour}:${event.dateTime.minute}",
                          style: AppTextStyles.black16Medium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Description",
                textAlign: TextAlign.start,
                style: AppTextStyles.black16Medium,
              ),
              SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.description,
                          style: AppTextStyles.black16Medium.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
