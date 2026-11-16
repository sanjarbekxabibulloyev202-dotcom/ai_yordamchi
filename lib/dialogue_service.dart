import 'dart:convert';
import 'package:http/http.dart' as http;

class DialogueService {
  final String apiKey;
  DialogueService({required this.apiKey});

  Future<String> getResponse(String userPrompt) async {
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": "Siz AI yordamchisiz. Darsda bo'lganingiz uchun kiruvchi qo'ng'iroqqa qisqa javob bering: $userPrompt"}
              ]
            }
          ]
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'] ?? "Hozir darsdaman, keyinroq bog'lanamiz.";
      }
    } catch (e) {
      print("API Xatolik: $e");
    }
    return "Hozir bandman, keyinroq aloqaga chiqaman.";
  }
}
