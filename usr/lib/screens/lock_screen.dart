import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // To access global state

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _codeController = TextEditingController();
  bool _isError = false;

  void _validateCode() {
    if (_codeController.text == globalBlockCode) {
      // Success - In a real app, this would temporarily unblock the specific overlay
      // For this demo, we just go back to the previous screen (which was the fake whatsapp)
      // But we need to handle the state so it doesn't immediately re-lock.
      // For simplicity in this demo, we just pop.
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Access Granted Temporarily'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        _isError = true;
      });
      _codeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'Restricted Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This channel is blocked for your protection. Enter the alphanumeric code to proceed.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _codeController,
                style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'Enter Code',
                  hintStyle: const TextStyle(color: Colors.white30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  errorText: _isError ? 'Incorrect Code' : null,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('UNLOCK'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Go back to dashboard or close app
                  Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
                },
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
