import 'package:firebase_storage/firebase_storage.dart';
class VeidoApi {

Future<String> getVideoUrl(String fileName) async {
  try {
    final ref = FirebaseStorage.instance.ref().child('videos/$fileName');
    return await ref.getDownloadURL();
  } catch (e) {
    print("Error fetching video URL: $e");
    throw e;
  }
}
}