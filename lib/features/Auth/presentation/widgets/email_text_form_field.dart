import 'package:flutter/material.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({super.key});

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        textEditingController: _emailTextEditingController,
        validator: (p0) => Validators.emailValidator(p0!),
        keyboardType: TextInputType.emailAddress,
        inputTextStyle: const TextStyle(fontSize: 10, color: Colors.white),
        hintText: 'Enter your email',
        prefixIcon:
            Assets.images.icons.emailIcon.image(color: AppColors.whiteBlack),
        label: 'Email');
  }
}
