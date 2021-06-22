import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages == true
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            children: [
              const Text(
                '📝',
                style: TextStyle(
                  fontSize: 130,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) => context.read<SignInFormBloc>().add(
                      SignInFormEvent.emailChanged(value),
                    ),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold<String?>(
                      (l) => l.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (r) => null,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context.read<SignInFormBloc>().add(
                      SignInFormEvent.passwordChanged(value),
                    ),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .password
                    .value
                    .fold<String?>(
                      (l) => l.maybeMap(
                        shortPassword: (_) => 'Password too short',
                        orElse: () => null,
                      ),
                      (r) => null,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed(),
                            );
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
