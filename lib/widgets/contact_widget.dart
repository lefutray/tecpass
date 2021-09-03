part of 'widgets.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget(this.contact, this.isSelected, {Key? key, this.onChanged}) : super(key: key);

  final Contact contact;
  final bool isSelected;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        contact.displayName,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
      ),
      secondary: _Avatar(contact: contact),
      subtitle: Text(
        contact.phones.isEmpty ? 'Sin número' : contact.phones.first.number,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
      ),
      activeColor: Colors.white,
      checkColor: Colors.black,
      onChanged: onChanged,
      selected: isSelected,
      value: isSelected,
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    Key? key,
    required this.contact,
    this.icon = Icons.person,
  }) : super(key: key);

  final Contact contact;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (contact.photoOrThumbnail != null) {
      return CircleAvatar(
        backgroundImage: MemoryImage(contact.photoOrThumbnail!),
      );
    }
    return CircleAvatar(
      child: Icon(icon),
    );
  }
}
