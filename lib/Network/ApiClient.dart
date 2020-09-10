import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:coba_part2/Utils/Constans.dart';


Future<Map> getPics(String searchTerm) async {
  final String url = "https://pixabay.com/api/?key=${Constans.API_KEY}&q=$searchTerm&image_type=photo&pretty=true";
  print(url);
  final response = await http.get(url);
  return json.decode(response.body);
}