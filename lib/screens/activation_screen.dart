import 'package:flutter/material.dart';
import '../services/activation_service.dart';

class ActivationScreen extends StatefulWidget {
  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final TextEditingController _requestCodeController = TextEditingController();
  final TextEditingController _activationCodeController =
      TextEditingController();
  String? _error;
  bool _activated = false;

  @override
  void initState() {
    super.initState();
    _requestCodeController.text = ActivationService.generateRequestCode();
  }

  void _activate() async {
    final code = _activationCodeController.text.trim();
    final result = await ActivationService.activate(code);
    if (result) {
      setState(() => _activated = true);
      Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, '/'),
      );
    } else {
      setState(() => _error = 'رمز التفعيل غير صحيح');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تفعيل التطبيق',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 24),
              TextField(
                controller: _requestCodeController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Request Code'),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _activationCodeController,
                decoration: InputDecoration(labelText: 'Activation Code'),
              ),
              if (_error != null) ...[
                SizedBox(height: 8),
                Text(_error!, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 24),
              ElevatedButton(onPressed: _activate, child: Text('تفعيل')),
              if (_activated)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تم التفعيل بنجاح!',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
