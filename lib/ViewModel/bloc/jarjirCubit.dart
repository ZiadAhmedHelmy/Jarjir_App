import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gargirak_app/ViewModel/bloc/JarjirStates.dart';
import '../data/local/dataBase.dart';

class JarjirCubit extends Cubit<JarjirStates> {
  JarjirCubit() : super(JarjirInitial());

  static JarjirCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  TextEditingController namePlant = TextEditingController();
  TextEditingController descriptionPlant = TextEditingController();
  int currentIndex = 0;

  Future<void> addPlant() async {
    await DioHelper.initDb();
    await DioHelper.addPlant(namePlant.text, descriptionPlant.text);
  }

  List<Map<String, dynamic>> plants = [];
  Future<void> getAllPlant() async {
    emit(GetAllPlantLoading());
    await DioHelper.initDb();
    DioHelper.getAllPlant().then((value) {
      plants = value;
      print(value);
      emit(GetAllPlantSuccess());
    }).catchError((error) {
      emit(GetAllPlantError());
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    dataFromControllerToFeild();
    emit(ChangeIndexState());
  }

  Future<void> dataFromControllerToFeild() async {
    namePlant.text = plants[currentIndex]["title"];
    descriptionPlant.text = plants[currentIndex]["description"];
  }

  void clearController() {
    namePlant.clear();
    descriptionPlant.clear();
  }
}
