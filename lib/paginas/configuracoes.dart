import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/meutexto.dart';
import '../paginas/login.dart';
import '../paginas/perfil.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  User? user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    final auth = FirebaseAuth.instance;
    setState(() {
      user = auth.currentUser;
    });
  }

  void _abrirLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const Login()))
        .then((_) => _checkUser()); // Atualiza ao voltar do login
  }

  void _abrirPerfil() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Perfil()));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: MeuTexto(
          texto: "Configurações",
          cor: Colors.white,
          tamanhoFonte: 20,
        ),
        elevation: 4,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.08,
            vertical: screenSize.height * 0.05,
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botão Tema (mesmo que antes)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black38),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.light_mode, color: Colors.black87),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Alternar tema desabilitado')),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Tema",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Aqui mostramos botão LOGIN ou PERFIL, dependendo do estado do usuário
              if (user == null)
                ElevatedButton(
                  onPressed: _abrirLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: _abrirPerfil,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Perfil: ${user!.email}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
