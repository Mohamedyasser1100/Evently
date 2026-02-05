import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constatnt/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/widgets/event_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final events = snapshot.data!.docs
                .map(
                  (doc) => EventDM.fromJson(doc.data() as Map<String, dynamic>),
                )
                .where((event) => event.isFavorite)
                .toList();

            if (events.isEmpty) {
              return const Center(child: Text("No favorites yet ❤️"));
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: EventWidget(eventDM: events[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
