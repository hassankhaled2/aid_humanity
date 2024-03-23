import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/items/donation_form_item.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDonationWithTextWidget extends StatefulWidget {
  AddDonationWithTextWidget({super.key});

  @override
  State<AddDonationWithTextWidget> createState() =>
      _AddDonationWithTextWidgetState();
}

class _AddDonationWithTextWidgetState extends State<AddDonationWithTextWidget> {
  final GlobalKey<FormState> formState = GlobalKey();
  final List<TextEditingController> textControllers = [
    // Initialize with one text field
    TextEditingController()
  ];
  List<Map<String, dynamic>> classifiedItems = [];

  @override
  void initState() {
    super.initState();
    // Clear the initial text field
    textControllers.first.text = '';
  }

  void addTextField() {
    setState(() {
      textControllers.add(TextEditingController());
    });
  }

  List<String> getDescriptions() {
    return textControllers.map((controller) => controller.text.trim()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: addTextField,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      body: SingleChildScrollView(
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
                    return DescriptionTextField(
                      controller: textControllers[index],
                      onRemove: () {
                        setState(() {
                          textControllers.removeAt(index);
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Additional check for at least one non-empty input
                Row(
                  children: [
                    BlocConsumer<ClassificaitonCubit, ClassificaitonState>(
                      listener: (context, state) {
                        if (state is KnnClassificaitonsSuccessState) {

                          print("Classification successful"); //hena
                          print(state.knnOutput);
                          final knnOutput = state.knnOutput;
                          if (knnOutput != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DonationFormItem(
                                  items: state.knnOutput,
                                  isKnn: true,
                                ),
                              ),
                            );
                          } else {
                            // Handle null knnOutput
                            print("knnOutput is null");
                          }
                        }
                      },
                      builder: (context, state) {
                        // Replace this builder part with the modified code
                        if (state is ClassificaitonLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return DefaultElevatedButton(
                          onPressed: () {
                            if (formState.currentState!.validate() &&
                                textControllers
                                    .any((c) => c.text.trim().isNotEmpty)) {
                              List<String> descriptions = getDescriptions();
                              BlocProvider.of<ClassificaitonCubit>(context)
                                  .knnClassification(descriptions);
                            } else {
                              // Show a snackbar for missing input
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter a description for your donation.'),
                                ),
                              );
                            }
                          },
                          text: "Submit",
                          radius: 10,
                          width: context.getDefaultSize() * 24.0,
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
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
              decoration: const InputDecoration(
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
