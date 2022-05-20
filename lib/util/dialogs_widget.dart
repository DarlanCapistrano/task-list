  import 'package:flutter/material.dart';

  Widget dialogDeleteAllToDoListConfirmation(BuildContext context){
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      children: [
        const Text("Aviso", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        const Text("Você deseja mesmo excluir todas as tarefas? Esta ação é irreversível.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(fixedSize: const Size(80, 0)),
              child: Text("NÃO", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[800])),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(80, 0), primary: Colors.black),
              child: const Text("SIM", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
  }