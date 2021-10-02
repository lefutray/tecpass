part of 'helpers.dart';

String? phoneToString(String number) {
  final roots = number.split(' ').last.split('-');

  var formatted = '';

  for (var element in roots) {
    formatted += element;
  }

  if (formatted.isEmpty) return null;

  return formatted;
}
