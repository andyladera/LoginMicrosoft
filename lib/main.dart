import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Tus importaciones de pantallas
import 'firebase_options.dart'; // El archivo generado por flutterfire
import 'home_screen.dart';      // Tu pantalla principal (para usuarios logueados)
import 'login_screen.dart';     // Tu pantalla de login (la del Paso 3)

void main() async {
  // 1. Asegura que Flutter esté listo
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inicializa Firebase usando el archivo firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Microsoft Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      
      // 3. Aquí está la magia (El "Listener")
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          
          // Mientras revisa el estado de auth
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Si el stream tiene datos (un User), el usuario está logueado
          if (snapshot.hasData) {
            // Muestra la pantalla principal
            return const HomeScreen(); 
          }

          // Si no tiene datos (null), el usuario no está logueado
          // Muestra la pantalla de inicio de sesión
          return const LoginScreen();
        },
      ),
    );
  }
}