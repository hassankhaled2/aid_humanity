import 'package:aid_humanity/core/constants/strings/faliures_strings.dart';
import 'package:flutter/material.dart';

class FaliureWidget extends StatelessWidget {
  const FaliureWidget({
    super.key,
    required this.faliureName,
  });
  final String faliureName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(_mapFaliureToImagePath(faliureName)),
    );
  }

  String _mapFaliureToImagePath(String faliureName) {
    switch (faliureName) {
      case OFFLINE_FALIURE_MESSAGE:
        return "assets/pics/offline_image.png";
  
      case No_Data_FALIURE_MESSAGE:
        return "assets/pics/no_requests_image.png";

      default:
        return "assets/pics/server_error_image.png";  
    }
  }
}
