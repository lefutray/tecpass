import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/bloc/login/login_bloc.dart';
import 'package:tec_pass/models/form_submission_status.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/widgets/customtextfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) Navigator.of(context).pushReplacementNamed('home');
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ListView(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Center(child: AppLogo()),
                    SizedBox(height: constraints.maxHeight * 0.35),
                    _Options(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TextFields(),
        _Buttons(),
      ],
    );
  }
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _TextFields extends StatelessWidget {
  const _TextFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Correo Electrónico',
                    icon: Icons.alternate_email,
                    initialValue: state.email,
                    onChanged: (username) => context.read<LoginBloc>().add(LoginEmailChanged(username)),
                    validator: state.validEmail,
                  ),
                  CustomTextField(
                    labelText: 'Contraseña',
                    icon: Icons.lock_open_outlined,
                    initialValue: state.password,
                    autofillHints: [AutofillHints.password],
                    onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                    validator: state.validPassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('register'),
              child: Text('Registrarme', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300)),
              style: TextButton.styleFrom(
                primary: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.formStatus is FormSubmitting) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                  child: Text('Ingresar'),
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.comfortable,
                    side: BorderSide(color: Colors.white70, width: 1),
                    primary: Theme.of(context).scaffoldBackgroundColor,
                  ),
                );
              },
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: TextButton(
            onPressed: () {},
            child: Text(
              '¿Perdiste la contraseña? Recupera tu cuenta.',
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
            ),
            style: TextButton.styleFrom(primary: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ],
    );
  }
}
