import 'package:chat_app/helpers/alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/header.dart';
import 'package:chat_app/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Header(title: 'Registro'),
                _Form(),
                Label(title: 'Ya tienes una cuenta?', subtitle: 'Ingresa ahora!', route: 'login'),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(
                        fontWeight: FontWeight.w200
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_outlined,
            placeholder: 'Usuario',
            textInputType: TextInputType.text,
            textEditingController: nameController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            textInputType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textEditingController: passwordController,
            isPassword: true,
          ),
          CustomBotton(
            text: 'Ingresar',
            onPressed: authService.loading
              ? null
              : () async{
                bool registerStatus = await authService.register(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                if(registerStatus){
                  socketService.connect();
                  Navigator.pushReplacementNamed(context, 'users');
                } else{
                  showAlert(context, 'Intente de nuevo', 'Hubo un error al crear su usuario, por favor intentelo más tarde');
                }
              }
          )
        ],
      ),
    );
  }
}
