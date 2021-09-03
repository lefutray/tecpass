part of 'helpers.dart';

Future confirmationPopup(
  BuildContext context, {
  required String title,
  String? message,
  Function()? onConfirm,
  Function()? onCancel,
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: message == null ? null : Text(message),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            onCancel?.call();
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        MaterialButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.pop(context);
          },
          child: Text('Sí'),
        ),
      ],
    ),
  );
}
