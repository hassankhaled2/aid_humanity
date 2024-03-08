import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/text_form_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class SliverUSerFormWidget extends StatefulWidget {
   SliverUSerFormWidget({super.key, required this.displayName, required this.email, required this.photoUrl,});
   final String displayName;
  final String email;
  final String photoUrl;
  @override
  State<SliverUSerFormWidget> createState() => _SliverUSerFormWidgetState();
}

class _SliverUSerFormWidgetState extends State<SliverUSerFormWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     'Name',
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text:  widget.displayName),
                      obscureText: false,
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text:widget.email),
                      obscureText: false,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text: "Omar Salama"),
                      obscureText: false,
                      prefixIcon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text: "Omar Salama"),
                      obscureText: false,
                      prefixIcon: Icons.lock_open_outlined,
                      keyboardType: TextInputType.text,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Address",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      maxLines: 5,
                      controller: TextEditingController(text: "htrhrthrthrthrthrthrttttttttttttttttttnghghthtttttttttttttttttttttbbbbbbbbbbbbbbbbbbbbbbbbbbbbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffngggggggggggggggggggggggggggggggggggggggggggggggggfffffffffffffffffffffffffffffffffffffttttttttttttttttttttttttttttttttttttt"),
                      obscureText: false,
                      prefixIcon: Icons.location_on_outlined,
                      keyboardType: TextInputType.text,
                      labelText: null,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: context.getDefaultSize() * 30,
          ),
        ],
      ),
    );
  }
}
