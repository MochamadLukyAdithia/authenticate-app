import 'dart:typed_data';
import 'package:http/http.dart' as http;

const String apiKey = "sqJvaWUwaSUUNDy4gvcT2rJc";

class RemoveBg {
  Future<Uint8List> removeBackground(String imagePath) async {
    var request = await http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imagePath));
    request.headers.addAll({"X-API-Key": apiKey});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(response);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception('Error' + response.statusCode.toString());
    }
  }
}
