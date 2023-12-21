import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VTelegaButton extends StatelessWidget {
  final String adress;
  const VTelegaButton({super.key, required this.adress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _launchTelegram(adress);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: _telegaColor,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/telega_logo.png'),
          const Text(
            'Join us',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

void _launchTelegram(String adress) async {
  String url = adress;
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

const _telegaColor = Color(0xFF2F9DED);
