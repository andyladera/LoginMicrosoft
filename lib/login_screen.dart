import 'package:flutter/material.dart';
import 'microsoft_signin_button.dart'; // Importa el archivo que creaste

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... otros widgets que puedas tener (login con email/pass, etc.)

            const Text('Inicia sesión con tu cuenta:'),
            const SizedBox(height: 20),

            // 3. Añade el botón aquí:
            const MicrosoftSignInButton(),

          ],
        ),
      ),
    );
  }
}