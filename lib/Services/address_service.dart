import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressService {
  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    final apiKey = dotenv.env['CHAVE_API_GOOGLE_MAPS'];
    if (apiKey == null || apiKey.isEmpty) {
      return 'Chave de API não configurada';
    }

    try {
      final uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {
          'latlng': '$lat,$lng',
          'key': apiKey,
          'language': 'pt-BR',
        },
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List?;
        if (results != null && results.isNotEmpty) {
          return results[0]['formatted_address'] as String;
        }
      }
      return 'Endereço não encontrado';
    } catch (e) {
      return 'Sem conexão';
    }
  }
}