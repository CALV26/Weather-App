import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallpaper_model.dart';

class WallpaperService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.unsplash.com/photos/random';
  final String _apiKey = '8sqcdAnXNwoLk0p3RQuw5T_JjiK4cRierYLayID3fCE';

  WallpaperService();

  Future<Wallpaper> getWallpaper(String qry) async {
    Uri url = Uri.parse('$BASE_URL?query=$qry&orientation=portrait&client_id=$_apiKey');    

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Wallpaper.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load wallpaper');
    }
  }
}
