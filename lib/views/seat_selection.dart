import 'package:flutter/material.dart';
import 'package:ticketz_frontend/model/movie.dart';
import 'package:ticketz_frontend/model/seat.dart';

class SeatSelectionPage extends StatefulWidget {
  final Movie movie;

  const SeatSelectionPage({Key? key, required this.movie}) : super(key: key);

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<List<Seat>> seats = [];
  List<Seat> selectedSeats = [];
  String selectedShowtime = '';

  @override
  void initState() {
    super.initState();
    selectedShowtime = widget.movie.showtimes.first;
    _generateSeats();
  }

  void _generateSeats() {
    seats = [];
    const int rows = 3;
    const int seatsPerRow = 5;

    for (int row = 0; row < rows; row++) {
      List<Seat> rowSeats = [];
      for (int seat = 0; seat < seatsPerRow; seat++) {
        // Simula alguns assentos ocupados
        SeatStatus status = SeatStatus.available;
        if ((row == 1 && seat == 2)) {
          status = SeatStatus.occupied;
        }

        rowSeats.add(Seat(
          id: '${row}_$seat',
          row: row,
          number: seat,
          status: status,
        ));
      }
      seats.add(rowSeats);
    }
  }

  void _toggleSeat(Seat seat) {
    if (seat.status == SeatStatus.occupied) return;

    setState(() {
      if (seat.status == SeatStatus.selected) {
        seat.status == SeatStatus.available;
        selectedSeats.removeWhere((s) => s.id == seat.id);
        // Atualiza o assento na matriz
        seats[seat.row][seat.number] = Seat(
          id: seat.id,
          row: seat.row,
          number: seat.number,
          status: SeatStatus.available,
        );
      } else {
        selectedSeats.add(seat);
        // Atualiza o assento na matriz
        seats[seat.row][seat.number] = Seat(
          id: seat.id,
          row: seat.row,
          number: seat.number,
          status: SeatStatus.selected,
        );
      }
    });
  }

  Color _getSeatColor(Seat seat) {
    switch (seat.status) {
      case SeatStatus.available:
        return Colors.grey[600]!;
      case SeatStatus.occupied:
        return Colors.red[400]!;
      case SeatStatus.selected:
        return Colors.green[400]!;
    }
  }

  double _getSeatPrice(Seat seat) {
    return 15.0;
  }

  double _getTotalPrice() {
    return selectedSeats.fold(0.0, (sum, seat) => sum + _getSeatPrice(seat));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[900]!, Colors.black],
          ),
        ),
        child: Column(
          children: [
            // Movie Info
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 90,
                      color: Colors.grey[700],
                      child: Icon(
                        Icons.movie,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.movie.genre} • ${widget.movie.duration}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Showtime Selection
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: widget.movie.showtimes.length,
                itemBuilder: (context, index) {
                  final showtime = widget.movie.showtimes[index];
                  final isSelected = selectedShowtime == showtime;

                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(showtime),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedShowtime = showtime;
                          // Reset seat selection when changing showtime
                          selectedSeats.clear();
                          _generateSeats();
                        });
                      },
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[300],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Screen indicator
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'TELA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Seats Grid
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: seats.asMap().entries.map((entry) {
                      int rowIndex = entry.key;
                      List<Seat> rowSeats = entry.value;

                      return Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row label
                            Container(
                              width: 30,
                              child: Text(
                                String.fromCharCode(
                                    65 + rowIndex), // A, B, C...
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ...rowSeats.map((seat) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                child: GestureDetector(
                                  onTap: () => _toggleSeat(seat),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: _getSeatColor(seat),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            seat.status == SeatStatus.selected
                                                ? Colors.green
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${seat.number + 1}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            // Row label (right side)
                            Container(
                              width: 30,
                              child: Text(
                                String.fromCharCode(65 + rowIndex),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Legend
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LegendItem(
                    color: Colors.grey[600]!,
                    label: 'R\$ 15,00',
                  ),
                ],
              ),
            ),

            if (selectedSeats.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border(
                    top: BorderSide(color: Colors.grey[700]!, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${selectedSeats.length} assento(s) selecionado(s)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Total: R\$ ${_getTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implementar reserva
                        _showBookingConfirmation(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'RESERVAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(
            'Reserva Confirmada!',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filme: ${widget.movie.title}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Horário: $selectedShowtime',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Assentos: ${selectedSeats.map((s) => '${String.fromCharCode(65 + s.row)}${s.number + 1}').join(', ')}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Total: R\$ ${_getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Volta para home
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
