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
      title: Row(
        children: [
          _Avatar(contact: contact),
          SizedBox(width: 15),
          Text(
            '${contact.displayName}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: this.isSelected ? Colors.white : Colors.white70),
          ),
        ],
      ),
      onChanged: this.onChanged,
      value: this.isSelected,
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    Key? key,
    required this.contact,
    this.radius = 18,
    this.icon = Icons.person,
  }) : super(key: key);

  final Contact contact;
  final double radius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (contact.photoOrThumbnail != null) {
      return CircleAvatar(
        backgroundImage: MemoryImage(contact.photoOrThumbnail!),
        radius: radius,
      );
    }
    return CircleAvatar(
      radius: radius,
      child: Icon(icon),
    );
  }
}
