import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
class LoginScreen extends StatelessWidget {
  TextEditingController correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(decoration: InputDecoration(labelText: 'Contraseña')),
            ElevatedButton(
              onPressed: () {
                String correoDeUsuario = correoController.text;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InicioSesionScreen(correoDeUsuario: correoDeUsuario),
                  ),
                );
              },
              child: Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoverPasswordScreen()),
                );
              },
              child: Text('Recuperar Contraseña'),
            ),
            TextButton(
              onPressed: () {
                //launch('https://www.facebook.com');
              },
              child: Text('Iniciar con Facebook'),
            ),
            TextButton(
              onPressed: () {
                //launch('https://www.gmail.com');
              },
              child: Text('Iniciar con Gmail'),
            ),
          ],
        ),
      ),
    );
  }
}

class InicioSesionScreen extends StatefulWidget {
  String correoDeUsuario;
  String nickDeUsuario = 'No se escogió un nick aún';
  InicioSesionScreen({required this.correoDeUsuario});
  @override
  _InicioSesionScreenState createState() => _InicioSesionScreenState();
}

class _InicioSesionScreenState extends State<InicioSesionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Sesión'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('¡Bienvenido, ${widget.nickDeUsuario}!'),
            Image.network(
              'https://s1.ppllstatics.com/lasprovincias/www/multimedia/202112/12/media/cortadas/gatos-kb2-U160232243326NVC-1248x770@Las%20Provincias.jpg',
              width: 100.0,
              height: 100.0,
            ),
            Text('Nick: ${widget.nickDeUsuario}'),
            Text('Correo: ${widget.correoDeUsuario}'),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarPerfilScreen(correoActual: widget.correoDeUsuario, nickActual: widget.nickDeUsuario),
                  ),
                );
                if (result != null && result is Map<String, String>) {
                  String nuevoCorreo = result['correo'] ?? widget.correoDeUsuario;
                  String nuevoNick = result['nick'] ?? widget.nickDeUsuario;
                  setState(() {
                    widget.correoDeUsuario = nuevoCorreo;
                    widget.nickDeUsuario = nuevoNick;
                  });
                }
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarPerfilScreen extends StatefulWidget {
  final String correoActual;
  final String nickActual;

  EditarPerfilScreen({required this.correoActual, required this.nickActual});

  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  TextEditingController correoController = TextEditingController();
  TextEditingController nickController = TextEditingController();

  @override
  void initState() {
    super.initState();
    correoController.text = widget.correoActual;
    nickController.text = widget.nickActual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Nuevo Correo'),
            ),
            TextField(
              controller: nickController,
              decoration: InputDecoration(labelText: 'Nuevo Nick'),
            ),
            ElevatedButton(
              onPressed: () {
                String nuevoCorreo = correoController.text;
                String nuevoNick = nickController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cambios guardados: Correo: $nuevoCorreo, Nick: $nuevoNick'),
                    duration: Duration(seconds: 5),
                  ),
                );
                Navigator.pop(context, {'correo': nuevoCorreo, 'nick': nuevoNick});
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecoverPasswordScreen extends StatelessWidget {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Contraseña')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(labelText: 'Contraseña Actual'),
            ),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: 'Nueva Contraseña'),
            ),
            TextField(
              controller: repeatPasswordController,
              decoration: InputDecoration(labelText: 'Repetir Contraseña'),
            ),
            ElevatedButton(
              onPressed: () {
                String currentPassword = currentPasswordController.text;
                String newPassword = newPasswordController.text;
                String repeatPassword = repeatPasswordController.text;

                if (newPassword == repeatPassword) {
                  currentPassword = newPassword;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Se cambió a la nueva contraseña'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Las contraseñas no coinciden.'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: Text('Cambiar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
