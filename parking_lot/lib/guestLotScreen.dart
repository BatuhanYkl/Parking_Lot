// guestlotScreen.dart

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'parking_slot.dart';

class GuestInfoScreen extends StatelessWidget {
  final Color isuMavisi = const Color.fromARGB(255, 6, 112, 171);
  final Color isuAcikMavisi = const Color.fromARGB(255, 8, 130, 196);
  final List<ParkingSlot> parkingSlots;

  const GuestInfoScreen(this.parkingSlots, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isuMavisi,
        title: const Text('Park Yerleri', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: isuAcikMavisi,
      // Responsive bir şekilde park yerlerini göster
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Container(
                color: isuAcikMavisi,
                child: LayoutBuilder(builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: (constraints.maxWidth / 125).floor(),
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(
                      parkingSlots.length,
                      (index) => ParkingSlotWidget(
                        parkingSlot: parkingSlots[index],
                        slotNumber: index + 1,
                      ),
                    ),
                  );
                }))),
      ),
    );
  }
}

class ParkingSlotWidget extends StatelessWidget {
  final ParkingSlot parkingSlot;
  final int slotNumber;

  const ParkingSlotWidget({
    super.key,
    required this.parkingSlot,
    required this.slotNumber,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = parkingSlot.isOccupied ? Colors.red : Colors.green;

    return Card(
      elevation: 3,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Park $slotNumber', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          Text(parkingSlot.isOccupied ? 'Dolu' : 'Boş', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
