import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'We value your feedback and inquiries. If you have any questions, suggestions, or concerns related to Travisor - The Travel Advisor, feel free to contact us using the information below.\n',
              style: TextStyle(fontSize: 16.0),
            ),
            _buildContactItem(Icons.email, 'Email', 'support@travisor.com'),
            _buildContactItem(Icons.phone, 'Phone', '+91 9072200430'),
            _buildContactItem(Icons.location_on, 'Address', '123 Main Street, City, Country'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                value,
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}
