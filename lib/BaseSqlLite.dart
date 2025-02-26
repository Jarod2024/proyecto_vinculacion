import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'user_data.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users (
          email TEXT PRIMARY KEY,
          password TEXT NOT NULL,
          rol TEXT NOT NULL
        )
      ''');
    });
  }

    // Insertar usuario en la base de datos SQLite
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    
    try {
      // Intentamos insertar el nuevo usuario
      return await db.insert('users', user);
    } catch (e) {
      // Si ya existe un usuario con el mismo correo, se puede ignorar o manejar el error
     debugPrint("Error al insertar usuario: $e");
      return -1;  // Retornamos -1 si hubo un error
    }
  }
    // Obtener todos los usuarios
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Obtener un solo usuario por su email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return result.first; // Retorna el primer usuario encontrado
      // ignore: dead_code
      debugPrint("Usuario encontrado: ${result.first}");
    }
    return null; // Si no se encuentra, retorna null
  }
  // Función para eliminar la base de datos completamente
  Future<void> deleteDatabaseFile() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'user_data.db');
    await deleteDatabase(path);
    _database = null; // Resetear la referencia para que se vuelva a crear
    debugPrint("Base de datos eliminada correctamente.");
  }
}
