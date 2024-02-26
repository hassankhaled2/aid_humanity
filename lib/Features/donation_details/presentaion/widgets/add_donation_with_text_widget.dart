import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/items/donation_form_item.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDonationWithTextWidget extends StatefulWidget {
  AddDonationWithTextWidget({super.key});

  @override
  State<AddDonationWithTextWidget> createState() => _AddDonationWithTextWidgetState();
}

class _AddDonationWithTextWidgetState extends State<AddDonationWithTextWidget> {
  final GlobalKey<FormState> formState = GlobalKey();

  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 130, left: 20, right: 20),
              child: TextFormField(
                controller: text,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'can not to be empty';
                  }
                  return null;
                },
                enabled: true,
                decoration: const InputDecoration(
                    hintText: 'Enter Your Description Item',
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: context.getDefaultSize() * 9.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: BlocConsumer<ClassificaitonCubit, ClassificaitonState>(
                    listener: (context, state) {
                      if (state is KnnClassificaitonsSuccessState) {
                        print("omarrrr");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DonationFormItem(
                                  items:state.knnOutput,
                                      isKnn: true,
                                    )));
                      }
                    },
                    builder: (context, state) {
                      if (state is ClassificaitonLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return DefaultElevatedButton(
                        onPressed: () {
                          if (formState.currentState!.validate()) BlocProvider.of<ClassificaitonCubit>(context).knnClassification(text.text);
                        },
                        text: "Submit",
                        radius: 10,
                        width: context.getDefaultSize() * 24.0,
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }
}
