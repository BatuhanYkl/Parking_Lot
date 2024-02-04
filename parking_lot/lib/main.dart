import 'package:flutter/material.dart';
import 'package:parking_lot/loginScreen.dart';
import 'WelcomeScreen.dart';
import 'guestlotScreen.dart';
import 'parking_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final List<ParkingSlot> parkingSlots =
      List.generate(20, (index) => ParkingSlot(false));

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/parking': (context) => ParkingLotScreen(parkingSlots),
        '/login': (context) => LoginScreen(),
        '/guestInfo': (context) => GuestInfoScreen(parkingSlots),
        '/register': (context) => RegisterScreen(),
      },
    ));
  }
}

class ParkingLotScreen extends StatefulWidget {
  final List<ParkingSlot> parkingSlots;

  // Park yerleri listesini burdan asıl class'a yönlendiriyor
  // Asıl class'ta kullanıcı adı yüklendiği için initState lazım
  // Bu yüzden de StatefulWidget mecbur
  const ParkingLotScreen(this.parkingSlots, {super.key});

  @override
  ParkingLotScreenState createState() => ParkingLotScreenState();
}

class ParkingLotScreenState extends State<ParkingLotScreen> {
  final Color isuMavisi = const Color.fromARGB(255, 6, 112, 171);
  final Color isuAcikMavisi = const Color.fromARGB(255, 8, 130, 196);
  late String username = "";

  // Kullanıcı adını username adlı late variable'a yüklüyoruz
  Future<void> usernameYukle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? '';
  }

  // Personel park ekranı açılmadan kullanıcı adını yükle
  @override
  void initState() {
    super.initState();
    usernameYukle();

    // Personel park ekranının açılmadan önceki frame'de kullanıcı adını yükle
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Yüklendiğinden emin olmak için setState kullanıyoruz
      setState(() {
        usernameYukle();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isuMavisi,
        title: const Text(
          'Park Yerleri',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
          color: isuAcikMavisi,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Text(
                    "Hoş Geldiniz, $username!",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  )),
              // Park alanlarının tamamını göster 
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ParkingLot(widget.parkingSlots)))
            ],
          )),
    );
  }
}

class ParkingLot extends StatelessWidget {
  final List<ParkingSlot> parkingSlots;

  const ParkingLot(this.parkingSlots, {super.key});

  // Park alanlarını ekran boyutuna göre değişken bir şekilde göster
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.count(
        crossAxisCount: (constraints.maxWidth / 150).floor(),
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: List.generate(
          parkingSlots.length,
          (index) => ParkingSlotWidget(
              parkingSlot: parkingSlots[index],
              slotNumber: index + 1,
              onSlotStatusChanged: () {
                (context as Element).markNeedsBuild();
              }),
        ),
      );
    });
  }
}

class ParkingSlotWidget extends StatelessWidget {
  final ParkingSlot parkingSlot;
  final int slotNumber;
  final VoidCallback onSlotStatusChanged;

  const ParkingSlotWidget(
      {super.key,
      required this.parkingSlot,
      required this.slotNumber,
      required this.onSlotStatusChanged});

  // Personel için park alanlarını değiştirebilecek park alanı kardı göster
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = parkingSlot.isOccupied ? Colors.red : Colors.green;

    return Card(
      elevation: 3,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Park $slotNumber', style: const TextStyle(fontSize: 20.0)),
          Text(parkingSlot.isOccupied ? 'Dolu' : 'Boş',
              style: const TextStyle(fontSize: 18.0)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              parkingSlot.isOccupied = !parkingSlot.isOccupied;
              onSlotStatusChanged();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 4), child: Text(parkingSlot.isOccupied ? 'Boşalt' : 'Doldur',
                style: const TextStyle(fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
