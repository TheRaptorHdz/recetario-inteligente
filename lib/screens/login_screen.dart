import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  bool _isLogin = true;
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);

    try {
      if (_isLogin) {
        await _auth.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await _auth.registrar(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator()
                  : Text(_isLogin ? 'Iniciar sesión' : 'Registrarse'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _isLogin = !_isLogin);
              },
              child: Text(_isLogin
                  ? 'Crear cuenta'
                  : 'Ya tengo cuenta'),
            )
          ],
        ),
      ),
    );
  }
}