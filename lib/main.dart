import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gargirak_app/View/Screens/homeScreen.dart';
import 'package:gargirak_app/ViewModel/bloc/jarjirCubit.dart';
import 'package:gargirak_app/ViewModel/data/local/dataBase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JarjirCubit()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
