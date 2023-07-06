import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/core/layout/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/constants.dart';
import '../../data/models/note.dart';

import '../cubits/note/note_cubit.dart';
import 'add_or_update_note.dart';
import 'note_details.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NoteCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColor.backgroundColor,
      appBar: appBarWidget(),
      body: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is MessageAddUpdateDelete) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: SystemColor.pimary,
            ));
            context.read<NoteCubit>().getAllNotes();
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: SystemColor.pimary,
            ));
          }
          if (state is LoadedNotesState) {
            var notes = state.notes;
            return notes.isEmpty ? noDataAvailable() : notesList(notes);
          }

          return Center(
            child: Text(
              'something happened ...',
              style: TextStyle(
                  color: SystemColor.pimary,
                  fontSize: 20.sp,
                  fontFamily: 'Desis'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: SystemColor.pimary,
          child: Icon(
            Icons.add,
            color: SystemColor.backgroundColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddOrUpdateScreen(
                  isAdd: true,
                  note: Note('', ''),
                );
              },
            ));
          }),
    );
  }

  Center noDataAvailable() {
    return Center(
        child: Text(
      'no data available ..',
      style: TextStyle(
          color: SystemColor.pimary, fontSize: 20.sp, fontFamily: 'Desis'),
    ));
  }

  Padding notesList(List<Note> notes) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
          pattern: [
            WovenGridTile(
              15.w / 18.w,
            ),
            WovenGridTile(
              8.w / 10.w,
              crossAxisRatio: 0.9,
              alignment: AlignmentDirectional.centerEnd,
            ),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: notes.length,
          (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return NoteDetails(
                    note: Note(notes[index].title, notes[index].body),
                  );
                },
              ));
            },
            child: singleNote(notes, index, context),
          ),
        ),
      ),
    );
  }

  GridTile singleNote(List<Note> notes, int index, BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: Constants.colors[index % 4],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.2.w),
        padding: const EdgeInsets.only(left: 20, right: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            noteAppBar(notes, index, context),
            noteBody(notes, index),
          ],
        ),
      ),
    );
  }

  Widget noteBody(List<Note> notes, int index) {
    return Expanded(
      child: Text(
        notes[index].body!,
        textAlign: TextAlign.start,
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Constants.iconColors[index % 4],
            fontSize: 16.sp,
            fontFamily: 'Dosis'),
      ),
    );
  }

  Container noteAppBar(List<Note> notes, int index, BuildContext context) {
    return Container(
      width: 50.w,
      margin: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
           
            width: 25.w,
            child: Text(
              notes[index].title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Constants.iconColors[index % 4],
                  fontSize: 20.sp,
                  fontFamily: 'Kablammo'),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Constants.iconColors[index % 4],
              size: 20,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Are you sure?'),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                          onPressed: () async {
                            context
                                .read<NoteCubit>()
                                .deleteNote(notes[index].title!);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'))
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 9.w),
          child: Icon(Icons.notifications),
        )
      ],
      title: Text(
        'Memories',
        style: TextStyle(
            color: SystemColor.pimary, fontSize: 20.sp, fontFamily: 'Desis'),
      ),
      backgroundColor: const Color.fromARGB(255, 231, 223, 232),
    );
  }
}
