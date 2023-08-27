import '../views/pages/Home/AdmHome.dart';
import '../views/pages/Home/UserHome.dart';

class NavbarViewModel {
  final bool isAdm; 
  NavbarViewModel({required this.isAdm});

  escolheTelaHome(){
    return isAdm ? const AdmHome() : const UserHome();
  }
}