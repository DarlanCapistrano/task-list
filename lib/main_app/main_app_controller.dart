import 'package:my_tasks/main_app/main_app_repository.dart';
import 'package:my_tasks/main_app/settings_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:my_tasks/util/color_theme.dart';

class MainController {
  static final MainController _mainController = MainController._();

  MainController._();

  @override
  factory MainController(){
    return _mainController;
  }

  final MainRepository _mainRepository = MainRepository();

  Future<void> initMainApp() async{
    await _mainRepository.initRepository();
    setSettings();
  }

  Future<void> setSettings() async{
    bool hasSettings = await _mainRepository.hasSettings();
    if(!hasSettings){
      await _mainRepository.insertDefaultSettings();
    }
    Settings settings = await _mainRepository.findSettings();
    chooseAppTheme(settings.appTheme);
  }

  void closeMainController(){
    controllerAppTheme.close();
  }

  final BehaviorSubject<AppTheme> controllerAppTheme = BehaviorSubject<AppTheme>();

  void chooseAppTheme(AppTheme theme){
    ColorsApp.chooseAppTheme(theme);
    _mainRepository.updateAppTheme(theme);
    controllerAppTheme.sink.add(theme);
  }
}