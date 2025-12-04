import 'package:flutter/material.dart';

// Mock global state for the demo
String? globalBlockCode;
bool isBlockingEnabled = false;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (globalBlockCode != null) {
      _codeController.text = globalBlockCode!;
    }
  }

  void _toggleBlocking(bool value) {
    if (value && (globalBlockCode == null || globalBlockCode!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set an alphanumeric code first')),
      );
      return;
    }
    setState(() {
      isBlockingEnabled = value;
    });
  }

  void _saveCode() {
    if (_codeController.text.isNotEmpty) {
      setState(() {
        globalBlockCode = _codeController.text;
        isBlockingEnabled = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Protection code saved and active')),
      );
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isBlockingEnabled ? Colors.green.shade50 : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isBlockingEnabled ? Colors.green : Colors.orange,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isBlockingEnabled ? Icons.check_circle : Icons.warning_amber_rounded,
                    color: isBlockingEnabled ? Colors.green : Colors.orange,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBlockingEnabled ? 'System Active' : 'Protection Inactive',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          isBlockingEnabled
                              ? 'WhatsApp Channels are blocked.'
                              : 'Minors can access all content.',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Configuration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Configuration Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Block WhatsApp Channels'),
                      subtitle: const Text('Requires code to view channels'),
                      value: isBlockingEnabled,
                      onChanged: _toggleBlocking,
                      secondary: const Icon(Icons.block, color: Colors.red),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Set Alphanumeric Unlock Code',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _codeController,
                            decoration: const InputDecoration(
                              hintText: 'e.g., SafeChild2024',
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _saveCode,
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This code will be required to unlock the Channels tab.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Test & Verify',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Simulation Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/simulation');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color(0xFF128C7E),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.phone_android),
                label: const Text(
                  'Simulate Child Experience',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Opens a mock WhatsApp interface to test the blocking functionality.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
