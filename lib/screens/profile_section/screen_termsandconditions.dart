import 'dart:ui';

import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travisor Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''Terms and Conditions

1. Introduction

Welcome to Travisor - The Travel Advisor. By using this app, you agree to be bound by the following Terms and Conditions. Please read these terms carefully before using the app.

2. Use of the App

2.1 Eligibility:

Travisor is intended for use by individuals who are at least 13 years old. If you are under 13, you are not allowed to use the app.

2.2 Account Information:

You are responsible for maintaining the confidentiality of your account information and agree to accept responsibility for all activities that occur under your account.

2.3 Prohibited Activities:

You agree not to engage in any unlawful or unauthorized use of the app. This includes but is not limited to violating any applicable laws or regulations, infringing on the rights of others, or transmitting harmful content.

3. Intellectual Property

The content and materials available in Travisor, including but not limited to text, graphics, logos, button icons, images, and software, are the property of Travisor or its licensors and are protected by applicable copyright and trademark laws.

4. Privacy

Travisor respects your privacy and handles your personal information in accordance with our Privacy Policy. By using the app, you consent to the collection, use, and sharing of your information as described in the Privacy Policy.

5. Disclaimers

5.1 Accuracy of Information:

While we strive to provide accurate and up-to-date information, Travisor does not warrant the completeness, reliability, or accuracy of the content available in the app.

5.2 Third-Party Content:

Travisor may contain links to third-party websites or services that are not owned or controlled by us. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party websites or services.

6. Limitation of Liability

Travisor and its affiliates shall not be liable for any direct, indirect, incidental, consequential, or special damages arising out of or in any way related to your use of the app.

7. Changes to the Terms and Conditions

Travisor may update these Terms and Conditions from time to time without prior notice. Your continued use of the app after such modifications constitutes your acceptance of the revised Terms and Conditions.

8. Contact Us

If you have any questions or concerns about these Terms and Conditions, please contact us at [contact email address].

By using Travisor, you agree to be bound by these Terms and Conditions. Thank you for using Travisor - The Travel Advisor!''',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}