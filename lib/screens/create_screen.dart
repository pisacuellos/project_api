import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _avatar = '';
  int _birthDate = 2000;
  String _order = '';
  double _note = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nuevo Personaje'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00BCD4), Color(0xFF2196F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Detalles del Nuevo Personaje',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Nombre',
                      icon: Icons.person,
                      validator: 'Por favor, ingrese el nombre',
                      onSaved: (value) => _name = value!,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'URL del Avatar',
                      icon: Icons.link,
                      validator: 'Por favor, ingrese la URL del avatar',
                      onSaved: (value) => _avatar = value!,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Fecha de Nacimiento (Año)',
                      icon: Icons.cake,
                      keyboardType: TextInputType.number,
                      validator: 'Por favor, ingrese un año válido',
                      onSaved: (value) => _birthDate = int.parse(value!),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Poder',
                      icon: Icons.star,
                      validator: 'Por favor, ingrese el poder',
                      onSaved: (value) => _order = value!,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Nota Inicial:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _note,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: _note.toStringAsFixed(1),
                      activeColor: Colors.blue,
                      inactiveColor: Colors.blue.shade100,
                      onChanged: (value) {
                        setState(() {
                          _note = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          Character newCharacter = Character(
                            id: '', // Se genera automáticamente en MockAPI
                            name: _name,
                            avatar: _avatar,
                            birthDate: _birthDate,
                            order: _order,
                            note: _note,
                          );

                          try {
                            await apiService.createCharacter(newCharacter);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Personaje creado con éxito')),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error al crear el personaje: $e')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF2196F3),
                      ),
                      child: const Text(
                        'Crear Personaje',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required String validator,
    TextInputType keyboardType = TextInputType.text,
    required Function(String?) onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validator;
        }
        if (keyboardType == TextInputType.number && int.tryParse(value) == null) {
          return 'Ingrese un número válido';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
