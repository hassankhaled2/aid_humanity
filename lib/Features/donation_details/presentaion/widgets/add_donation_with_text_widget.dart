import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/items/donation_form_item.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class AddDonationWithTextWidget extends StatefulWidget {
  AddDonationWithTextWidget({super.key});

  @override
  State<AddDonationWithTextWidget> createState() => _AddDonationWithTextWidgetState();
}

class _AddDonationWithTextWidgetState extends State<AddDonationWithTextWidget> {
  final GlobalKey<FormState> formState = GlobalKey();
  final List<TextEditingController> textControllers = [];// List of controllers
  List<Map<String, dynamic>> classifiedItems = [];


  void addTextField() {
    setState(() {
      textControllers.add(TextEditingController());
    });
  }

  List<String> getDescriptions() {
    return textControllers.map((controller) => controller.text).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: textControllers.length,
                itemBuilder: (context, index) {
                  return DescriptionTextField( // Use DescriptionTextField widget
                    controller: textControllers[index],
                    onRemove: () {
                      setState(() {
                        textControllers.removeAt(index);
                      });
                    },
                  );
                },
              ),


              SizedBox(
                height: 20,
              ),
              DefaultElevatedButton(
                onPressed: addTextField,
                text: "Add More",
                radius: 10,
                width: context.getDefaultSize() * 24.0,
              ),

              SizedBox(
                height: 25,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: BlocConsumer<ClassificaitonCubit, ClassificaitonState>(
                      listener: (context, state) {
                        if (state is KnnClassificaitonsSuccessState) {
                          print("Classification successful");
                          print(state.knnOutput);
                          // Handle successful classification (navigate, display results)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DonationFormItem(
                                items: state.knnOutput, // Pass the classified items
                                isKnn: true,
                              ),
                            ),
                          );
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
                            if (formState.currentState!.validate()) {
                              List<String> descriptions = getDescriptions();
                              // Pass the list of descriptions for classification
                              BlocProvider.of<ClassificaitonCubit>(context)
                                  .knnClassification(descriptions);
                            }
                          },
                          text: "Submit",
                          radius: 10,
                          width: context.getDefaultSize() * 24.0,
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onRemove;

  const DescriptionTextField({
    super.key,
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'what do you want to donate ?',
              ),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
