import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Bạn có chắc chắn xóa?'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Không',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            'Có',
            style: TextStyle(color: Color.fromARGB(255, 5, 136, 244)),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'Lỗi!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Oke',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}
