import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingFeaturesScreen extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;

  UpcomingFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: screenWidth,
            child: Center(
              child: Image(
                image: const AssetImage('assets/up-coming.png'),
                width: screenWidth,
                height: screenHeight / 2.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Upcoming Features",
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth / 18,
                      // fontFamily: "Khmer OS"
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _buildFeatureRow(
                    title: 'Dark Mode',
                    subtitle:
                    'Save your eyes and conserve battery life with our new dark mode feature',
                    icon: FontAwesomeIcons.adjust,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _buildFeatureRow(
                    title: 'Push Notifications',
                    subtitle:
                    'Never miss an important update again with our new push notification feature',
                    icon: FontAwesomeIcons.bell,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(subtitle),
            ],
          ),
        ),
      ],
    );
  }
}