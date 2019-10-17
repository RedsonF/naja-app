import 'package:flutter/material.dart';
import 'package:naja/Home.dart';
import 'package:naja/Service.dart';

class Inserir extends StatefulWidget{

 int _currentIndex;
  dynamic state;

  Inserir(this._currentIndex) {
    state = new _InsertPageState(this._currentIndex);
  }

  @override
  _InsertPageState createState() => state;
}

class _InsertPageState extends State<Inserir> {
  BuildContext _context;
  int _currentIndex;

  final repositorio = new Service();

  final List<String> categorias = [
    'TVs',
    'Celular',
    'Videogame',
    'Eletrodomésticos'
  ];

  String _nome;
  String _categoria;
  String _preco;
  String _quantidade;
  String _img;

  // Controllers
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController imagemController = TextEditingController();

  // para validar
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _InsertPageState(this._currentIndex) {
    // setando a categoria;
    this._categoria = categorias.elementAt(this._currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Naja",
          ),
          centerTitle: true,
        ),
        // adicionou a ScrollView para evitar que o teclado cubra os inputs
        body: SingleChildScrollView(
          // é possivel aplicar o padding pois é uma propriedade do SingleChildScrollView
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              // ele vai esticar todo o eixo horizontal
              crossAxisAlignment: CrossAxisAlignment.center,
              // filhos da nossa coluna
              children: <Widget>[
                buildTextField('Nome', nomeController),
                Divider(),
                // Não alterar label
                buildTextField('Preço', precoController),
                Divider(),
                // Não alterar label
                buildTextField('Quantidade', quantidadeController),
                Divider(),
                buildTextField('Imagem', imagemController),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _cadastrar();
                        }
                      },
                      color: Colors.green,
                      child: Text(
                        "CADASTRAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _cadastrar() async {
    this._nome = nomeController.text;
    this._preco = precoController.text;
    this._quantidade = quantidadeController.text;
    this._img = imagemController.text;

    print(nomeController.text);
    print(precoController.text);
    print(quantidadeController.text);
    print(imagemController.text);
    await this.repositorio.cadastrarItem(this._nome, this._categoria, this._preco, this._quantidade, this._img);

    _clearAll();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemList()));
  }

  void _clearAll() {
    this.nomeController.text = '';
    this.precoController.text = '';
    this.quantidadeController.text = '';
    this.imagemController.text = '';
  }

// Widget para os inputs
  Widget buildTextField(String label, TextEditingController controller) {
    if (label == 'Quantidade' || label == 'Preço') {
      return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: label, labelStyle: TextStyle(color: Colors.black)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 15),
        // para pegar os valores de forma fácil
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "Obrigatório!";
          }
        },
      );
    } else if (label == 'Imagem') {
      return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: label, labelStyle: TextStyle(color: Colors.black)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 15),
        // para pegar os valores de forma fácil
        controller: controller,
      );
    } else {
      return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: label, labelStyle: TextStyle(color: Colors.black)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 15),
        // para pegar os valores de forma fácil
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "Obrigatório!";
          }
        },
      );
    }
  }
}