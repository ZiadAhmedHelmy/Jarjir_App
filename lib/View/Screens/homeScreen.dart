import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gargirak_app/View/Screens/addPlantScreen.dart';
import 'package:gargirak_app/View/Screens/editPlantScreen.dart';
import 'package:gargirak_app/ViewModel/bloc/JarjirStates.dart';
import 'package:gargirak_app/ViewModel/bloc/jarjirCubit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = JarjirCubit.get(context);
    return BlocProvider.value(
      value: cubit..getAllPlant(),
      child: BlocConsumer<JarjirCubit, JarjirStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Plants",
                style: GoogleFonts.lobster(color: Colors.black, fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: cubit.plants.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "ملقتش داتا جبتلك",
                            style: GoogleFonts.lalezar(
                                fontSize: 25, color: Colors.black),
                          ),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "جرجير",
                            style: GoogleFonts.lalezar(
                                fontSize: 25, color: Colors.green),
                          )
                        ]),
                      ),
                      Image.asset(
                        "assets/images/output-onlinepngtools (1).png",
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.plants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100],
                        ),
                        child: ListTile(
                          onTap: () {
                            cubit.changeIndex(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditAddPlant(),
                                ));
                          },
                          leading: Image.asset(
                              "assets/images/output-onlinepngtools (1).png"),
                          title: Text(cubit.plants[index]["title"]),
                          subtitle: Text(
                              cubit.plants[index]["description"].toString()),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPlant(),
                    ));
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
