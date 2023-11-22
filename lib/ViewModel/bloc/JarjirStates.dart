// ignore: file_names
abstract class JarjirStates{}

class JarjirInitial extends JarjirStates{}

// getAllPlantStates 👍
class GetAllPlantLoading extends JarjirStates{}
class GetAllPlantSuccess extends JarjirStates{}
class GetAllPlantError extends JarjirStates{}

class ChangeIndexState extends JarjirStates{}