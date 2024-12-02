import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  final String apiUrl = 'https://67446322b4e2e04abea200a1.mockapi.io/archivotormentas/characters';

  // Obtener todos los personajes
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  // Obtener un personaje por ID
  Future<Character> fetchCharacterById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el personaje');
    }
  }

  // Crear un nuevo personaje
  Future<void> createCharacter(Character character) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(character.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el personaje');
    }
  }

  // Actualizar un personaje
  Future<void> updateCharacter(String id, Character character) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(character.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el personaje');
    }
  }
}
