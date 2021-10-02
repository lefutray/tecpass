import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/features/auth/common/form_submission_status.dart';
import 'package:tec_pass/features/auth/login/bloc/login_bloc.dart';
import 'package:tec_pass/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          Navigator.of(context).pushReplacementNamed('home');
          context.read<LoginBloc>().add(LoginFinished());
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0.0, -0.7),
                child: AppLogo(),
              ),
              Align(
                alignment: Alignment(0.0, 0.7),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: _Options(),
                ),
              ),
            ],
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

class _TextFields extends StatelessWidget {
  const _TextFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: AutofillGroup(
            onDisposeAction: AutofillContextAction.cancel,
            child: Form(
              key: state.formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Correo Electrónico',
                    icon: Icons.alternate_email,
                    initialValue: state.email,
                    inputType: TextInputType.emailAddress,
                    onChanged: (username) => context.read<LoginBloc>().add(LoginEmailChanged(username)),
                    validator: (_) => state.validateField('email'),
                  ),
                  CustomTextField(
                    labelText: 'Contraseña',
                    icon: Icons.lock_open_outlined,
                    initialValue: state.password,
                    autofillHints: [AutofillHints.password],
                    inputType: TextInputType.visiblePassword,
                    onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                    validator: (_) => state.validateField('password'),
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
              onPressed: () {
                context.read<LoginBloc>().add(LoginPasswordChanged(''));
                Navigator.of(context).pushReplacementNamed('register');
              },
              child: Text('Registrarme', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300)),
              style: TextButton.styleFrom(primary: Theme.of(context).scaffoldBackgroundColor),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.formStatus is FormSubmitting) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginFinished());
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<LoginBloc>().add(LoginSubmitted());
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
