import 'dart:convert';

import 'package:music_app/models/band.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/models/song.dart';

class ApiService {
  static final ApiService _instance = ApiService._();
  static const String url = "http://192.168.1.39:3000";

  ApiService._();

  factory ApiService() {
    return _instance;
  }

  Future<List<Band>> getBands() async {
    final res = await http.get(Uri.parse("$url/band"));
    List bands = (jsonDecode(res.body) as List)
        .map((band) => Band.fromJson(band))
        .toList();
    return bands;
  }

  Future<List<Song>> getBandSongs(int id) async {
    final res = await http.get(Uri.parse("$url/band/$id/music"));
    List songs = (jsonDecode(res.body) as List)
        .map((song) => Song.fromJson(song))
        .toList();
    return songs;
  }

  Future<List> getBandImage(int id) async {
    final res = await http.get(Uri.parse("$url/band/$id/images"));
    return jsonDecode(res.body);
  }
}
