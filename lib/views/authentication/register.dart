import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/bloc/register/register_bloc.dart';
import 'package:tec_pass/helpers/rut.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/widgets/customtextfield.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

class _TextFields extends StatefulWidget {
  @override
  __TextFieldsState createState() => __TextFieldsState();
}

class __TextFieldsState extends State<_TextFields> {
  late TextEditingController _rutController;

  @override
  void initState() {
    super.initState();
    _rutController = TextEditingController(text: BlocProvider.of<RegisterBloc>(context).state.rut);
  }

  @override
  void dispose() {
    BlocProvider.of<RegisterBloc>(context).add(RegisterPasswordChanged(''));
    BlocProvider.of<RegisterBloc>(context).add(RegisterPasswordConfirmationChanged(''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: 'Nombre completo',
                hintText: 'John Doe',
                initialValue: state.fullName,
                icon: Icons.account_circle_outlined,
                validator: state.validateName,
                onChanged: (fullName) {
                  context.read<RegisterBloc>().add(RegisterFullNameChanged(fullName));
                },
              ),
              CustomTextField(
                labelText: 'Correo electrónico',
                hintText: 'john@doe.com',
                initialValue: state.email,
                inputType: TextInputType.emailAddress,
                icon: Icons.alternate_email,
                validator: state.validateEmail,
                onChanged: (email) {
                  context.read<RegisterBloc>().add(RegisterEmailChanged(email));
                },
              ),
              CustomTextField(
                labelText: 'Celular',
                hintText: '+569123456789',
                initialValue: state.mobile,
                inputType: TextInputType.phone,
                icon: Icons.phone,
                validator: state.validateMobile,
                onChanged: (mobile) {
                  context.read<RegisterBloc>().add(RegisterMobileChanged(mobile));
                },
              ),
              CustomTextField(
                labelText: 'RUT',
                hintText: '5.738.059-4',
                inputType: TextInputType.text,
                icon: Icons.fingerprint,
                controller: _rutController,
                validator: state.validateRUT,
                onChanged: (rut) {
                  RUTValidator.formatFromTextController(_rutController);
                  context.read<RegisterBloc>().add(RegisterRUTChanged(RUTValidator.formatFromText(rut)));
                },
              ),
              CustomTextField(
                labelText: 'Contraseña',
                hintText: 'Debe tener al menos 8 caracteres',
                initialValue: state.password,
                icon: Icons.lock_open_outlined,
                inputType: TextInputType.visiblePassword,
                obscureText: true,
                validator: state.validatePassword,
                onChanged: (password) {
                  context.read<RegisterBloc>().add(RegisterPasswordChanged(password));
                },
              ),
              CustomTextField(
                labelText: 'Confirmar contraseña',
                initialValue: state.passwordConfirmation,
                inputType: TextInputType.visiblePassword,
                icon: Icons.lock_open_outlined,
                obscureText: true,
                validator: state.validatePassword,
                onChanged: (passwordConfirmation) {
                  context.read<RegisterBloc>().add(RegisterPasswordConfirmationChanged(passwordConfirmation));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<RegisterBloc>().add(RegisterSubmitted());
                  }
                },
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
          );
        },
      ),
    );
  }
}
