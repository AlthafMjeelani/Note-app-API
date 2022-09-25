import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeleteNote extends StatelessWidget {
  const DeleteNote({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Are you Sure Want To Delete',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('No'),
        )
      ],
    );
  }
}
