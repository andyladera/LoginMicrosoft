import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MicrosoftSignInButton extends StatelessWidget {
  const MicrosoftSignInButton({Key? key}) : super(key: key);

  Future<void> _signInWithMicrosoft(BuildContext context) async {
    try {
      // 1. Crea el proveedor de OAuth
      final microsoftProvider = OAuthProvider('microsoft.com');

      // (Opcional) Añadir scopes si necesitas más datos
      // microsoftProvider.addScope('profile');
      // microsoftProvider.addScope('email');

      // 2. Inicia el flujo de inicio de sesión (abre la vista web)
      final userCredential = 
          await FirebaseAuth.instance.signInWithProvider(microsoftProvider);

      final User? user = userCredential.user;

      // 3. ¡Éxito! El usuario está en Firebase.
      if (user != null) {
        print('Inicio de sesión exitoso: ${user.displayName}');
        // NOTA: No navegues aquí. Deja que el StreamBuilder del Paso 4
        // se encargue de la navegación automáticamente.
      }

    } on FirebaseAuthException catch (e) {
      // Maneja errores de forma visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ocurrió un error inesperado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signInWithMicrosoft(context),
      // Puedes estilizarlo para que se parezca al botón oficial de Microsoft
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Aquí podrías poner el logo de Microsoft desde tus assets
          // Image.asset('assets/microsoft_logo.png', height: 20),
          // const SizedBox(width: 10),
          const Text('Iniciar sesión con Microsoft'),
        ],
      ),
    );
  }
}