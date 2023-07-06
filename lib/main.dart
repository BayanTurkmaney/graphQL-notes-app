import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app/buisness/cubits/note/note_cubit.dart';
import 'app/buisness/screens/home.dart';
import 'app/data/repos/note_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(
      create: (context) => NoteCubit(NoteRepository()),
      child: ResponsiveSizer(
        builder: (p0, p1, p2) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage(),
        );
        },
      ),
    );
  }
}
