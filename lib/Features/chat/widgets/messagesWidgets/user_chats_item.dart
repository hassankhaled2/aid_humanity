import 'package:aid_humanity/Features/chat/pages/chating_page.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class UserChatItem extends StatelessWidget {
  const UserChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ChatingPage())),
      child: SizedBox(
        
        width: double.infinity,
        child: Row(
          
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                "https://i.pinimg.com/736x/bf/b4/54/bfb454b2b6df93d772c88e866207db29--stunning-girls-beautiful-person.jpg",
              ),
              radius: context.getDefaultSize() * 2,
            ),
            SizedBox(
              width: context.getDefaultSize() * 1.2,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    "Menna Ahmed",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.getDefaultSize() * 1.8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: context.getDefaultSize() * 0.3,
                  ),
                  Text(
                    "Hello, Are you need any help?",
                    style: TextStyle(
                        color: AppColorsLight.primaryColor,
                        fontSize: context.getDefaultSize() * 1.4,
                        overflow: TextOverflow.ellipsis),
                  ),
                ])),
            const Spacer(),
            const Text("24/2/2023"),
          ],
        ),
      ),
    );
  }
}
