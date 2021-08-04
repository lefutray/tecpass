import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget(this.contact, this.isSelected, {Key? key, this.onChanged}) : super(key: key);

  final Contact contact;
  final bool isSelected;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        '${contact.displayName}',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: this.isSelected ? Colors.white : Colors.white70),
      ),
      onChanged: this.onChanged,
      value: this.isSelected,
    );
  }
}
