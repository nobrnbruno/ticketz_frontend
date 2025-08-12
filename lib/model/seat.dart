enum SeatStatus { available, occupied, selected }

class Seat {
  final String id;
  final int row;
  final int number;
  final SeatStatus status;

  Seat({
    required this.id,
    required this.row,
    required this.number,
    required this.status,
  });
}
