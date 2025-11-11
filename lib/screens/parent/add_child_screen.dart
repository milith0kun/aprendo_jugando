import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/mock_data_service.dart';
import '../../models/child.dart';
import '../../config/app_theme.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({Key? key}) : super(key: key);

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _pinController = TextEditingController();
  DateTime? _birthDate;
  int _selectedGrade = 1;
  String _selectedAvatarType = 'boy1';

  final List<String> _avatarTypes = ['boy1', 'boy2', 'girl1', 'girl2'];

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2010),
      lastDate: DateTime(2020),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      if (_birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona la fecha de nacimiento')),
        );
        return;
      }

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final newChild = Child(
        id: 'child_${DateTime.now().millisecondsSinceEpoch}',
        parentId: authProvider.currentUser!.id,
        username: _usernameController.text,
        displayName: _displayNameController.text,
        dateOfBirth: _birthDate!,
        grade: _selectedGrade,
        pin: _pinController.text,
        avatar: AvatarConfig(
          baseType: _selectedAvatarType,
        ),
        preferences: ChildPreferences(),
      );

      // Add to mock data
      MockDataService.mockChildren.add(newChild);

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Niño'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Información del Niño',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario (para login)',
                  prefixIcon: Icon(Icons.account_circle),
                  helperText: 'Sin espacios ni caracteres especiales',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre de usuario';
                  }
                  if (value.contains(' ')) {
                    return 'El usuario no puede contener espacios';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pinController,
                decoration: const InputDecoration(
                  labelText: 'PIN de 4 dígitos',
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un PIN';
                  }
                  if (value.length != 4) {
                    return 'El PIN debe tener 4 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Fecha de Nacimiento'),
                subtitle: Text(
                  _birthDate == null
                      ? 'Seleccionar fecha'
                      : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[400]!),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedGrade,
                decoration: const InputDecoration(
                  labelText: 'Grado Escolar',
                  prefixIcon: Icon(Icons.school),
                ),
                items: List.generate(6, (index) => index + 1)
                    .map((grade) => DropdownMenuItem(
                          value: grade,
                          child: Text('$grade° Grado'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGrade = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Selecciona un Avatar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _avatarTypes.map((type) {
                  final isSelected = type == _selectedAvatarType;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAvatarType = type;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor.withOpacity(0.2)
                            : Colors.grey[200],
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            type.contains('boy') ? Icons.boy : Icons.girl,
                            size: 40,
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.grey[600],
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleSave,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Guardar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
