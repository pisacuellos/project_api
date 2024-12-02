import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.avatar),
        ),
        title: Text(character.name),
        subtitle: Text('Poder: ${character.order}\nNacimiento: ${character.birthDate}'),
        trailing: Text('Nota: ${character.note.toStringAsFixed(1)}'),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: character.id, // Navegar a pantalla de detalles
          );
        },
      ),
    );
  }
}
