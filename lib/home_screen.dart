import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // --- 1. La lógica de Cerrar Sesión ---
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // NOTA: No necesitamos navegar manualmente.
      // El StreamBuilder en main.dart detectará el cambio
      // y mostrará la LoginScreen automáticamente.
    } catch (e) {
      // Es bueno manejar errores aquí también
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: $e')),
      );
    }
  }
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    // Obtenemos el usuario actual para mostrar su información
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          // --- 2. El Botón de Cerrar Sesión ---
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () => _signOut(context), // Llama a la función
          ),
          // -------------------------------
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              // El usuario de Microsoft tendrá un displayName
              user?.displayName ?? 'Usuario',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              // Y también un email
              user?.email ?? 'Sin email',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}