import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? imageUrl;

  const ProfilePic({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[350],
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl!) // Load the image from the URL
          : const AssetImage('images/default_profile.png') as ImageProvider, // Fallback to default
    );
  }
}
