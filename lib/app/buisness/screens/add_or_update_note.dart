// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/layout/colors.dart';
import '../../data/models/note.dart';
import '../cubits/note/note_cubit.dart';
import 'home.dart';

// ignore: must_be_immutable
class AddOrUpdateScreen extends StatelessWidget {
  bool isAdd;
  Note? note;

  AddOrUpdateScreen({
    Key? key,
    required this.isAdd,
    this.note,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title, body;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: SystemColor.backgroundColor,
        appBar: AppBar(backgroundColor:SystemColor.backgroundColor,
           iconTheme:  IconThemeData(color:SystemColor.pimary),),
        body: BlocListener<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDelete) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: SystemColor.pimary,
                ));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ));
              }
            },
            child: getChild(context)),
      ),
    );
  }

  SingleChildScrollView getChild(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
              padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
              child: formWidget(context)),
        );
  }

  Form formWidget(BuildContext context) {
    return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    isAdd ? 'Add New Note' : 'Update Note',
                    style: TextStyle(
                        color:SystemColor.pimary,
                        fontSize: 25.sp,
                        fontFamily: 'Kablammo'),
                  ),
                   SizedBox(
                    height: 5.h,
                  ),
                  titleFormField(),
                   SizedBox(
                    height: 5.h,
                  ),
                  bodyFormField(),
                   SizedBox(
                    height: 5.h,
                  ),
                  submitButton(context)
                ],
              ),
            );
  }

  Widget submitButton(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: SystemColor.pimary,
         
        ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        
                          if(isAdd){
                                  Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) {
                                        return HomePage();
                                      },
                                    ));
                               context
                                  .read<NoteCubit>()
                                  .addNote(Note(title, body));
                          }
    
                                  
                            else {context
                                  .read<NoteCubit>()
                                  .updateNote(
                                      note!.title!, Note(title, body));
                                      Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) {
                                        return HomePage();
                                      },
                                    ));
                            }
                        }
                      },
                      child: Text(isAdd ? 'add' : 'update', style: TextStyle(color: Colors.white),)),
    );
  }

  TextFormField bodyFormField() {
    return TextFormField(
                  initialValue: note!.body,
                  onSaved: (val) {
                    body = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) return 'should not be empty!';
                  },
                  maxLines: 6,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: isAdd
                              ? Color.fromARGB(255, 208, 172, 214)
                              : Colors.purple,
                          fontFamily: 'Densis'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.w),
                          borderSide: BorderSide(
                              color: isAdd
                                  ? Color.fromARGB(255, 208, 172, 214)
                                  : Colors.purple,
                              width: 0.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      labelText: 'body',
                      alignLabelWithHint: true),
                );
  }

  TextFormField titleFormField() {
    return TextFormField(
                  initialValue: !isAdd ? note!.title : null,
                  validator: (val) {
                    if (val!.isEmpty) return 'should not be empty!';
                   
                  },
                  onSaved: (val) {
                    title = val;
                  },
                  decoration: InputDecoration(
                      labelText: 'title',
                      labelStyle: TextStyle(
                          color: isAdd
                              ? Color.fromARGB(255, 208, 172, 214)
                              : Colors.purple,
                          fontFamily: 'Densis'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: isAdd
                                  ? Color.fromARGB(255, 208, 172, 214)
                                  : Colors.purple,
                              width: 0.2.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color:  Colors.purple,
                              width: 2))),
                );
  }
}
































