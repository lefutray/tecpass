import 'package:flutter/material.dart';
import 'package:tec_pass/helpers/rut.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/widgets/customtextfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ListView(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Center(child: AppLogo()),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  _TextFields(),
                  _Options(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TextFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _rutController = TextEditingController();
    void onChangedApplyFormat(String text) {
      RUTValidator.formatFromTextController(_rutController);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          labelText: 'Nombre completo',
          hintText: 'John Doe',
          icon: Icons.account_circle_outlined,
        ),
        CustomTextField(
          labelText: 'Correo electrónico',
          hintText: 'john@doe.com',
          inputType: TextInputType.emailAddress,
          icon: Icons.alternate_email,
        ),
        CustomTextField(
          labelText: 'Celular',
          hintText: '+569123456789',
          inputType: TextInputType.number,
          icon: Icons.phone,
        ),
        CustomTextField(
          labelText: 'RUT',
          hintText: '5.738.059-4',
          inputType: TextInputType.text,
          icon: Icons.fingerprint,
          controller: _rutController,
          onChanged: onChangedApplyFormat,
        ),
        CustomTextField(
          labelText: 'Contraseña',
          hintText: 'Debe tener al menos 8 caracteres',
          icon: Icons.lock_open_outlined,
          inputType: TextInputType.visiblePassword,
        ),
        CustomTextField(
          labelText: 'Confirmar contraseña',
          inputType: TextInputType.visiblePassword,
          icon: Icons.lock_open_outlined,
        ),
      ],
    );
  }
}

class _Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Crear Cuenta'),
            style: ElevatedButton.styleFrom(
              visualDensity: VisualDensity.comfortable,
              side: BorderSide(color: Colors.white70, width: 1),
              primary: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('login'),
            child: Text('¿Ya tienes una cuenta? Ingresa.', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300)),
            style: TextButton.styleFrom(
              primary: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
