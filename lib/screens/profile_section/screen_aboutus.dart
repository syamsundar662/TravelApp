
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The Travel Advisor',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Travisor is your ultimate travel companion, providing you with expert advice and personalized recommendations for your journeys around the world. Our mission is to make your travel experience unforgettable by offering you a platform that combines the power of cutting-edge technology with the knowledge and passion of seasoned travelers and locals.\n',
              style: TextStyle(fontSize: 16.0),
            ),
            const Text(
              'Our Features:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem('Comprehensive Destination Information', 'Discover detailed information about countless destinations worldwide, including popular landmarks, hidden gems, local culture, and more.'),
            _buildFeatureItem('Smart Recommendations', 'Get personalized travel recommendations based on your preferences and interests, helping you create a travel itinerary that suits your unique tastes.'),
            _buildFeatureItem('User-Generated Content', 'Join a vibrant community of travelers who share their experiences, photos, and tips, making Travisor a dynamic platform for travel inspiration.'),
            const SizedBox(height: 16.0),
            const Text(
              'Join us on our journey of exploration and adventure. Whether you are a seasoned globetrotter or embarking on your first trip, Travisor is here to be your faithful guide.\n',
              style: TextStyle(fontSize: 16.0),
            ),
            const Text(
              'Happy Traveling!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
