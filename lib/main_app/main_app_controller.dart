import 'package:rxdart/subjects.dart';
import 'package:my_tasks/util/color_theme.dart';

class MainController {
  static final MainController _mainController = MainController._();

  MainController._();

  @override
  factory MainController(){
    return _mainController;
  }

  void closeMainController(){
    controllerAppTheme.close();
  }

  final BehaviorSubject<ColorTheme> controllerAppTheme = BehaviorSubject<ColorTheme>();

  void chooseAppTheme(ColorTheme theme){
    ColorsApp.chooseAppTheme(theme);
    controllerAppTheme.sink.add(theme);
  }
}