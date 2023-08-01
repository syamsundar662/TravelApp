import 'package:flutter/material.dart';
  class PrivacyPolict extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''Welcome to Travisor - The Travel Advisor! This Privacy Policy outlines how we collect, use, disclose, and protect your personal information when you use our travel app, Travisor. We are committed to safeguarding your privacy and ensuring the security of your personal data. By using Travisor, you agree to the practices described in this Privacy Policy.

1. Information We Collect

1.1 Personal Information:

When you register for an account, we collect your name, email address, and optional profile information.
If you choose to connect through social media, we may collect certain information from your social media profile, subject to your privacy settings.
1.2 Location Data:

Travisor requires access to your device's location to provide location-based recommendations and services.
1.3 Usage Information:

We collect information about how you use the app, including search queries, interactions with places, and features used.
1.4 User-Provided Content:

You may choose to submit reviews, comments, or photos of places. Such content will be publicly visible to other users of Travisor.

2. How We Use Your Information

2.1 Personalization:

We use your information to personalize your experience with the app, including recommending places based on your preferences and location.
2.2 Communication:

We may use your email address to send you important updates, promotions, and newsletters. You can opt-out of these communications at any time.
2.3 Analytics:

We use data analytics to analyze app usage patterns and improve our services.
2.4 Legal Requirements:

We may use your information as required by law or to comply with legal processes.

3. How We Protect Your Information

3.1 Security:

We implement security measures to protect your personal information from unauthorized access, disclosure, or alteration.
3.2 Data Retention:

We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.

4. Sharing Your Information

4.1 Third-Party Services:

We may share your information with third-party service providers who assist us in operating the app, analyzing data, and providing customer support.
4.2 Aggregated Data:

We may share aggregated, anonymized data that does not personally identify you for analytics and market research purposes.
4.3 Legal Requirements:

We may disclose your information when required by law, court order, or government regulation.

5. Your Choices

5.1 Account Information:

You can review and update your account information at any time through the app settings.
5.2 Location Data:

You can control app access to your device's location through your device settings.
5.3 Opt-out:

You can opt-out of promotional emails by following the instructions in the email.

6. Children's Privacy

Travisor is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If you believe that we have inadvertently collected information from a child under 13, please contact us immediately.

7. Changes to this Privacy Policy

We may update this Privacy Policy from time to time. The date of the latest revision will be indicated at the beginning of this policy. We encourage you to review this Privacy Policy periodically to stay informed about how we protect your information.

8. Contact Us

If you have any questions or concerns about this Privacy Policy or your personal information, please contact us at [contact email address].

By using Travisor, you agree to the terms and conditions outlined in this Privacy Policy. Thank you for trusting Travisor as your travel advisor app!''',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
 