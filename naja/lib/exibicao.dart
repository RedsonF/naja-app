import 'package:flutter/material.dart';
import 'package:naja/home.dart';
import 'package:naja/Service.dart';

class Exibicao extends StatelessWidget{

  var _nome;
  var _categoria;
  var _preco;
  var _quantidade;
  var _img;
  var _id;

  Exibicao(this._nome, this._categoria, this._preco, this._quantidade, this._img, this._id);
  BuildContext _context;

  var repository = new Service();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(
            "Naja",
          ),
          centerTitle: true,
        ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Material(
          elevation: 4.0,
          borderRadius: new BorderRadius.circular(6.0),
          child: new ListView(
            children: <Widget>[
             _getImageNetwork(_img),
              _getBody(_nome, _categoria, _preco, _quantidade),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAlertDialog2(context);
        },
        tooltip: 'Remover',
        child: Icon(Icons.delete),
        backgroundColor: Colors.red
      )
    );
  }

  Widget _getImageNetwork(url){
    return new Container(
      
          height: 150.0,
          child: new Image.network(
            url,
            fit: BoxFit.cover)
        );
  }

  Widget _getBody(nome, categoria, preco, quantidade){
    return new Container(
      margin: new EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getName(nome),
          _getCategoria(categoria),
          _getValue(preco),
          _getQuantity(quantidade)
          
        ],
      ),
    );
  }

  _getName(nome) {
    return new Text("Nome: " + nome,
    style: new TextStyle(
        fontSize: 15.0),
    );
  }

  _getValue(valor) {
    return new Text("Preço: R\$ " + valor.toString(),
    style: new TextStyle(
        fontSize: 15.0),
    );
  }

  _getCategoria(categoria) {
    return new Text("Categoria: " + categoria,
    style: new TextStyle(
        fontSize: 15.0),
    );
  }

  _getQuantity(quantidade) {
    return new Container(
      child: new Text("Quantidade: " + quantidade.toString() + " unidades",
      style: new TextStyle(
        fontSize: 15.0),
      ),
    );
  }

  showAlertDialog2(BuildContext context) {
   Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
       Navigator.of(context).pop();
    },
  );

  Widget continuaButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      print(_id);
      print(_nome);
      repository.removeItem(_id);
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return ItemList();
    }));
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("Remover produto?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}