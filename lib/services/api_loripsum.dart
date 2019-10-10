import 'package:http/http.dart' as http;
import 'dart:async';

class LoripsumBloc {
  final streamController = StreamController<String>();
  Stream<String> get stream => streamController.stream;

  loadCarros() async {
    try {
      String text = await LoripsumApi.getLoripsum();

      streamController.add(text);
    } catch (e) {
      streamController.addError(e);
    }
  }

  void dispose() {
    streamController.close();
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    String url = 'https://loripsum.net/api';

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');

    return text;
  }
}
