import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  final int index;
  final List courses ;
  const CourseWidget({super.key, required this.index, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GridTile(
                    footer: Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 10),
                      color: Colors.grey,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        courses[index]["title"].toString(),
                        style: const TextStyle(
                          height: 1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child:  Image.asset(Assets.images.icon.path),
                  ),
                ),
              );
  }
}