// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gargirak_app/View/Screens/homeScreen.dart';
import 'package:gargirak_app/ViewModel/bloc/jarjirCubit.dart';
import 'package:gargirak_app/ViewModel/data/local/dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/customTextInput.dart';

class EditAddPlant extends StatelessWidget {
  const EditAddPlant({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = JarjirCubit.get(context);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Edit Plant",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                CustomTextInput(
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter Name of Planet';
                    }
                    return null;
                  },
                  controller: cubit.namePlant,
                  hint: "Plant Name",
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                ),
                CustomTextInput(
                  hint: "Description",
                  controller: cubit.descriptionPlant,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter Description of Planet';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    //todo Update plant to db
                    if (cubit
                        .formKey
                        .currentState!
                        .validate()) {
                      DioHelper.upDatePlant(
                        cubit
                                .plants[cubit.currentIndex]
                            ['id'],
                        cubit.namePlant.text,
                        cubit.descriptionPlant.text,
                      ).then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          )));
                    }
                  },
                  child: const Text("Update Plant"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    //todo delete plant to db
                    if (JarjirCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      DioHelper.deletePlant(
                        cubit.plants[cubit.currentIndex]['id'],
                      ).then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          )));
                    }
                  },
                  child: const Text("delete"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
