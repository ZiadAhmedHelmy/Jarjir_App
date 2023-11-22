import 'package:flutter/material.dart';
import 'package:gargirak_app/View/Screens/homeScreen.dart';
import 'package:gargirak_app/ViewModel/bloc/jarjirCubit.dart';
import 'package:gargirak_app/ViewModel/data/local/dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/customTextInput.dart';

class AddPlant extends StatelessWidget {
  const AddPlant({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = JarjirCubit.get(context);
    cubit.clearController();
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
            "Add Plant",
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
                    //todo add plant to db
                    if (JarjirCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      DioHelper.addPlant(
                        cubit.namePlant.text,
                        cubit.descriptionPlant.text,
                      ).then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          )));
                      JarjirCubit.get(context).clearController();
                    }
                  },
                  child: const Text("Add Plant to DB"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
