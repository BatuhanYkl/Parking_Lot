import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 112, 171),
      ),
      backgroundColor: const Color.fromARGB(255, 6, 112, 171),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hoş Geldiniz!',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 320,
              height: 2,
              color: Colors.white,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Misafir giriş ekranına giden buton
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/guestInfo');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        fixedSize: const Size(150, 200),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 80, // İkon boyutunu ayarlayabilirsiniz.
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Misafir Girişi',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Personel giriş ekranına giden buton
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        fixedSize: const Size(150, 200),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.white,
                            size: 80, // İkon boyutunu ayarlayabilirsiniz.
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Personel Girişi',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
