import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const id = '/terms-and-conditions';
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
Terms and Conditions

1. Introduction
Welcome to our application. By using our services, you agree to comply with and be bound by the following terms and conditions.

2. User Responsibilities
You are responsible for your use of this application. Any misuse or unauthorized activity will result in appropriate action.

3. Intellectual Property
All content within this application is the property of the respective owners. Unauthorized reproduction is prohibited.

4. Limitation of Liability
We are not liable for any damages resulting from the use or inability to use this application.

5. Changes to Terms
We reserve the right to modify these terms at any time. Continued use of the app constitutes acceptance of the updated terms.

For further inquiries, please contact the application owner.

By continue using this app You here by agree to the terms and conditions of the app.

Thank you for using our services!
                  ''',
                  style: const TextStyle(fontSize: 16.0, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
