import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    super.key,
    this.width = 120,
    this.height = 120,
    this.alignment = AlignmentDirectional.bottomEnd,
    required this.ontap,
    required this.child,
    required this.boxDecoration,
    this.addIcon,
  });

  final double width, height;
  final BoxDecoration boxDecoration;
  final Widget child;
  final Widget? addIcon;
  final Function(XFile) ontap;
  final AlignmentGeometry alignment;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap(),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: widget.width,
              height: widget.height,
              decoration: widget.boxDecoration,
              child: imagePath == null
                  ? widget.child
                  : Image.file(
                      imagePath!,
                      fit: BoxFit.cover,
                    ),
            ),
            if (widget.addIcon != null)
              Align(
                alignment: widget.alignment,
                child: widget.addIcon,
              )
          ],
        ),
      ),
    );
  }

  ontap() async {
    final ImagePicker picker = ImagePicker();
  
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    }
    imagePath = File(response.path);
    setState(() {
      
    });
    widget.ontap(response);
  }

}
