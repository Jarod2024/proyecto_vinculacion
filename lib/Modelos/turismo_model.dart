// turismo_model.dart

/// Modelo para Lugar Turístico
class LugarTuristicoModel {
  final String correo;
  final String numeroRegistroTuristico;
  final String tipoServicio;
  final String nombreEstablecimiento;
  final String capacidadAtencion;
  final String tarifasPorServicio;
  final String horariosOperacion;
  final String ubicacion;

  LugarTuristicoModel({
    required this.correo,
    required this.numeroRegistroTuristico,
    required this.tipoServicio,
    required this.nombreEstablecimiento,
    required this.capacidadAtencion,
    required this.tarifasPorServicio,
    required this.horariosOperacion,
    required this.ubicacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'numeroRegistroTuristico': numeroRegistroTuristico,
      'tipoServicio': tipoServicio,
      'nombreEstablecimiento': nombreEstablecimiento,
      'capacidadAtencion': capacidadAtencion,
      'tarifasPorServicio': tarifasPorServicio,
      'horariosOperacion': horariosOperacion,
      'ubicacion': ubicacion,
    };
  }

  factory LugarTuristicoModel.fromMap(Map<String, dynamic> map) {
    return LugarTuristicoModel(
      correo: map['correo'] ?? '',
      numeroRegistroTuristico: map['numeroRegistroTuristico'] ?? '',
      tipoServicio: map['tipoServicio'] ?? '',
      nombreEstablecimiento: map['nombreEstablecimiento'] ?? '',
      capacidadAtencion: map['capacidadAtencion'] ?? '',
      tarifasPorServicio: map['tarifasPorServicio'] ?? '',
      horariosOperacion: map['horariosOperacion'] ?? '',
      ubicacion: map['ubicacion'] ?? '',
    );
  }
}

/// Modelo para Registro de Visitante
class RegistroVisitanteModel {
  final String correo;
  final String cedula;
  final String nombre;
  final String telefono;
  final String opinionesValoraciones;

  RegistroVisitanteModel({
    required this.correo,
    required this.cedula,
    required this.nombre,
    required this.telefono,
    required this.opinionesValoraciones,
  });

  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'cedula': cedula,
      'nombre': nombre,
      'telefono': telefono,
      'opinionesValoraciones': opinionesValoraciones,
    };
  }

  factory RegistroVisitanteModel.fromMap(Map<String, dynamic> map) {
    return RegistroVisitanteModel(
      correo: map['correo'] ?? '',
      cedula: map['cedula'] ?? '',
      nombre: map['nombre'] ?? '',
      telefono: map['telefono'] ?? '',
      opinionesValoraciones: map['opinionesValoraciones'] ?? '',
    );
  }
}

/// Modelo para Emprendimiento Comunitario Turístico
class EmprendimientoComunitarioTuristico {
  final String correo;
  final String nombre;
  final List<String> servicios;

  EmprendimientoComunitarioTuristico({
    required this.correo,
    required this.nombre,
    required this.servicios,
  });

  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'nombre': nombre,
      'servicios': servicios,
    };
  }

  factory EmprendimientoComunitarioTuristico.fromMap(Map<String, dynamic> map) {
    return EmprendimientoComunitarioTuristico(
      correo: map['correo'] ?? '',
      nombre: map['nombre'] ?? '',
      servicios: List<String>.from(map['servicios'] ?? []),
    );
  }
}

/// Modelo para Estrategia de Turismo Comunitario
class EstrategiaTurismoComunitarioModel {
  final String correo;
  final String nombre;
  final List<String> acciones;

  EstrategiaTurismoComunitarioModel({
    required this.correo,
    required this.nombre,
    required this.acciones,
  });

  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'nombre': nombre,
      'acciones': acciones,
    };
  }

  factory EstrategiaTurismoComunitarioModel.fromMap(Map<String, dynamic> map) {
    return EstrategiaTurismoComunitarioModel(
      correo: map['correo'] ?? '',
      nombre: map['nombre'] ?? '',
      acciones: List<String>.from(map['acciones'] ?? []),
    );
  }
}
