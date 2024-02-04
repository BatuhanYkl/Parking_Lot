// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Giriş ekranını göster
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 112, 171),
        title: Center(
          child: Text(
            'Login',
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 30,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              shadows: [
                const Shadow(
                  color: Colors.black,
                  blurRadius: 0.5,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 80,
                child: ClipOval(
                  child: Image.asset(
                    'images/isu.jpg',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Entera basıldığında giriş kontrol ve giriş yapma
              TextField(
                controller: passwordController,
                onSubmitted: (value) {
                  loginCallBack(context);
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Giriş yapıldığında kullanıcı girişini kontrol et ve giriş yap
                onPressed: () {
                  checkLogin(
                      emailController.text, passwordController.text, context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                  child: Text('Giriş Yap',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              // Kayıt ol ekranına giden buton
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Padding(
                    padding:
                        EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Enter'a basıldığında giriş kontrolü
  void loginCallBack(BuildContext context) async {
    checkLogin(emailController.text, passwordController.text, context);
  }
}

Future<void> checkLogin(
    String enteredEmail, String enteredPassword, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String savedEmail = prefs.getString('email') ?? '';
  String savedPassword = prefs.getString('password') ?? '';

  // Eğer email ve şifre boş değilse ve kaydedilen değerlerle eşleşiyorsa
  // Personel park ekranına git
  if (savedEmail != '' &&
      savedPassword != '' &&
      enteredEmail == savedEmail &&
      enteredPassword == savedPassword) {
    Navigator.pushNamed(context, '/parking');
  } else {
    // Eğer giriş boş ise veya kaydedilen değerlerle uyuşmuyorsa
    // ekranda uyarı göster
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: const Text("tmams"));
    AlertDialog alert = AlertDialog(
      title: const Text('Uyari'),
      content: const Text('Giriş başarısız. Lütfen tekrar deneyin.'),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // Kayıt olma ekranı
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 112, 171),
        title: Center(
          child: Text(
            'Sign Up',
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 30,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              shadows: [
                const Shadow(
                  color: Colors.black,
                  blurRadius: 0.5,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //kayıt ol
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(20, 40),
                ),
                onPressed: () {
                  // Eğer email, şifre ve kullanıcı adı boş değil ise
                  // kayıt yap ve login ekranına geri dön
                  // eğer hatalıysa uyarı göster
                  if (emailController.text == '' ||
                      passwordController.text == '' ||
                      nameController.text == '') {
                    Widget okButton = TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text("tmams"));
                    AlertDialog alert = AlertDialog(
                      title: const Text('Uyarı'),
                      content: const Text(
                          'Giriş boş olamaz. Lütfen tekrar deneyin.'),
                      actions: [okButton],
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        });
                        return;
                  }
                  saveUserData(emailController.text, passwordController.text,
                      nameController.text);
                  Navigator.pushNamed(context, '/login');
                },
                child: const Padding(
                    padding:
                        EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Kullanıcı adı, şifre ve emaili kaydet
Future<void> saveUserData(
    String email, String password, String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);
  prefs.setString('username', username);
}
