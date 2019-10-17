import 'package:flutter/material.dart';
import 'package:naja/exibicao.dart';
import 'package:naja/Service.dart';

class Item extends StatelessWidget{
  var _nome;
  var _categoria;
  var _preco;
  var _quantidade;
  var _img;
  var _id;

  Item(this._nome, this._categoria, this._preco, this._quantidade, this._img, this._id);

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0,top: 0.0),
      child: InkWell(
            onTap: showDetail,
            splashColor: Colors.blue,
            child: _getListTile(),
          ),
    );
  }

  showDetail() {
    Navigator
    .of(_context)
    .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Exibicao(_nome, _categoria, _preco, _quantidade, _img, _id);
    }));
  }

   Widget _getListTile(){
    // Foi adicionado dentro de Container para adicionar altura fixa.
    return new Container(
      height: 95.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new FadeInImage.assetNetwork(placeholder: '', image: _img,fit: BoxFit.cover,width: 95.0,height: 95.0,),
          _getColumText(_nome,"R\$ " + _preco.toString(), _quantidade.toString() + " unidades"),
      ],

    ),
    );

  }

   Widget _getColumText(nome,valor, quantidade){

    return new Expanded(
        child: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              _getNameWidget(nome),
              _getValueWidget(valor.toString()),
              _getQuantidadeWidget(quantidade.toString())],
          ),
        )
    );
  }

  Widget _getNameWidget(String nome){
    return new Text(
      nome,
      maxLines: 1,
    );
  }

  Widget _getValueWidget(String valor) {
    return new Container(
      child: new Text(valor,maxLines: 2,),
    );
  }

  Widget _getQuantidadeWidget(String quantidade){
    return new Text(
      quantidade,
      maxLines: 2,
    );
  }

  Widget _getCategoryWidget(String date) {
    return new Text(date,
      style: new TextStyle(color: Colors.grey,fontSize: 10.0),);
  }
}