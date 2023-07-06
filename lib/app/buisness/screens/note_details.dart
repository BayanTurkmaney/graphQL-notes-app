import 'package:flutter/material.dart';
import 'package:notes_app/core/layout/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/models/note.dart';

import 'add_or_update_note.dart';

class NoteDetails extends StatelessWidget {
  final Note? note;
  const NoteDetails({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColor.detailsBgc,
      appBar: appBarWidget(context),
      body: getBody(),
    );
  }

  SingleChildScrollView getBody() {
    return SingleChildScrollView(
        child: Container(
      padding:  EdgeInsets.only(left: 10.w, top: 3.h, right: 2.w),
      child: Text(
        note!.body!,
        style:  TextStyle(
            color: Colors.white60, fontSize: 18.sp, fontFamily: 'Desis'),
      ),
    ));
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white70),
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: const Divider(color: Colors.white38),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddOrUpdateScreen(
                      note: Note(note!.title, note!.body),
                      isAdd: false,
                    );
                  },
                ));
              },
              icon: const Icon(Icons.edit))
        ],
        title: Text(
          note!.title!,
          textAlign: TextAlign.center,
          style:  TextStyle(
              color: Colors.white70, fontSize: 25.sp, fontFamily: 'Kablammo'),
        ),
        backgroundColor: SystemColor.detailsBgc);
  }
}
