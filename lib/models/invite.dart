part of 'models.dart';

class Invite {
  final DateTime date;
  final String recipientName;
  final InviteStatus status;
  final Place place;

  Invite({
    required this.date,
    required this.place,
    this.recipientName = "Dan",
    this.status = InviteStatus.pending,
  });
}

enum InviteStatus { accepted, declined, pending }
