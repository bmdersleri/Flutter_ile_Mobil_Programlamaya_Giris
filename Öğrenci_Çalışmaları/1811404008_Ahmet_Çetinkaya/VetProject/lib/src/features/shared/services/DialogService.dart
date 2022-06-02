import 'package:flutter/material.dart';

class DialogService {
  static showConfirmDialog(BuildContext context,
      {required String title,
      String content = '',
      String cancelText = 'İptal',
      Function? onCancel,
      String confirmText = 'Onayla',
      required Function onConfirm}) {
    void close(BuildContext context) => Navigator.of(context).pop();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                close(context);
                if (onCancel != null) onCancel();
              },
            ),
            ElevatedButton(
              child: Text(confirmText),
              onPressed: () {
                close(context);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }
}
