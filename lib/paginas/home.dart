import 'package:aula/helper.dart';
import 'package:aula/paginas/configuracoes.dart';
import 'package:aula/paginas/fatoDoDia.dart';
import 'package:aula/paginas/ilimitado.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text(
          "History.io",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
        elevation: 6,
        shadowColor: Colors.black45,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Abrir menu',
            ),
          ),
        ],
      ),
      body: HomeBody(
        isDarkMode: isDarkMode,
        theme: theme,
        onFatoDoDiaPressed: () => abrirPagina(context, const FatoDoDia()),
        onIlimitadoPressed: () => abrirPagina(context, const Ilimitado()),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade600),
            child: const Center(
              child: Text(
                'Mais opções',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.blue.shade700),
            title: const Text('Informações', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Informações'),
                  content: const Text(
                      'Este é um aplicativo History.io. Escolha o modo de jogo para começar!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue.shade700),
            title: const Text('Configurações', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              abrirPagina(context, const Configuracoes());
            },
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final bool isDarkMode;
  final ThemeData theme;
  final VoidCallback onFatoDoDiaPressed;
  final VoidCallback onIlimitadoPressed;

  const HomeBody({
    super.key,
    required this.isDarkMode,
    required this.theme,
    required this.onFatoDoDiaPressed,
    required this.onIlimitadoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Fundo clarinho, degrade sutil azul claro para branco
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          width: 320,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.blue.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.6),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bem-Vindo ao History.io!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  shadows: const [
                    Shadow(
                      color: Colors.blueAccent,
                      offset: Offset(1, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Vamos lá!\nEscolha o modo de jogo",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey.shade700,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: onFatoDoDiaPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 7,
                      shadowColor: Colors.blue.shade300,
                    ),
                    child: const Text(
                      "FATO DO DIA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onIlimitadoPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 7,
                      shadowColor: Colors.blue.shade300,
                    ),
                    child: const Text(
                      "ILIMITADO",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

