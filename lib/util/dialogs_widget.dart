  import 'package:flutter/material.dart';
import 'package:my_tasks/main_app/main_app_controller.dart';
import 'package:my_tasks/util/color_theme.dart';

  Widget dialogDeleteAllTasksConfirmation(BuildContext context){
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      backgroundColor: ColorsApp.dialogColor,
      children: [
        Text("Aviso", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: ColorsApp.secondaryColor, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Text("Você deseja mesmo excluir todas as tarefas? Esta ação é irreversível.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: ColorsApp.secondaryColor)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(fixedSize: const Size(80, 0), primary: Colors.red),
              child: Text("NÃO", textAlign: TextAlign.center, style: TextStyle(color: ColorsApp.secondaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(80, 0), primary: ColorsApp.widgetsColor),
              child: const Text("SIM", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
  }

  class DialogOpenSettings extends StatefulWidget {
    const DialogOpenSettings({Key? key}) : super(key: key);

    @override
    State<DialogOpenSettings> createState() => _DialogOpenSettingsState();
  }
  
  class _DialogOpenSettingsState extends State<DialogOpenSettings> {
    @override
    Widget build(BuildContext context) {
      return SimpleDialog(
        backgroundColor: ColorsApp.dialogColor,
        contentPadding: const EdgeInsets.all(12),
        children: [
          Text("Configurações", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: ColorsApp.secondaryColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Text("Escolha um tema", style: TextStyle(fontSize: 16, color: ColorsApp.secondaryColor)),
          const SizedBox(height: 4),
          Column(
            children: [
              InkWell(
                onTap: () => setState(() => MainController().chooseAppTheme(AppTheme.white)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 45,
                      child: RadioListTile<AppTheme>(
                        activeColor: ColorsApp.widgetsColor,
                        contentPadding: const EdgeInsets.all(0),
                        value: AppTheme.white,
                        groupValue: ColorsApp.colorAppTheme,
                        onChanged: (theme) => setState(() => MainController().chooseAppTheme(theme!)),
                      ),
                    ),
                    Text("Claro", style: TextStyle(color: ColorsApp.secondaryColor)),
                  ],
                ),
              ),
              InkWell(
                onTap: () => setState(() => MainController().chooseAppTheme(AppTheme.dark)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 45,
                      child: RadioListTile<AppTheme>(
                        activeColor: ColorsApp.widgetsColor,
                        contentPadding: const EdgeInsets.all(0),
                        value: AppTheme.dark,
                        groupValue: ColorsApp.colorAppTheme,
                        onChanged: (theme) => setState(() => MainController().chooseAppTheme(theme!)),
                      ),
                    ),
                    Text("Escuro", style: TextStyle(color: ColorsApp.secondaryColor)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(fixedSize: const Size(80, 0), primary: Colors.red),
                child: Text("OK", textAlign: TextAlign.end, style: TextStyle(color: ColorsApp.secondaryColor)),
              ),
            ],
          ),
        ],
      );
    }
  }