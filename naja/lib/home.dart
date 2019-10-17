import 'package:flutter/material.dart';
import 'package:naja/Service.dart';
import 'package:naja/Inserir.dart';
import 'package:naja/Item.dart';

class ItemList extends StatefulWidget{

  final state = new _ItemListPageState();

  @override
  _ItemListPageState createState() => state;
}

class _ItemListPageState extends State<ItemList>{
  
  List _categorys = ["TVs", "Celular", "Videogame", "Eletrodomésticos"];
  var _category_selected = 0;
  List _itens = new List();
  var repository = new Service();
  var _currentIndex = 0;
  BuildContext _context;

  @override
   Widget build(BuildContext context) {
    this._context = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: Text('Naja')
          ),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _getListCategory(),
            new Expanded(
              child: _getListViewWidget(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          inserir();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.green
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  inserir() {
    Navigator
    .of(_context)
    .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Inserir(_currentIndex);
    }));
   }

 @override
  void initState() {
    loadItens(_category_selected);
  }

  Widget _getListViewWidget(){

    var list = new ListView.builder(
        itemCount: _itens.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index){
          return _itens[index];
        }
    );
    return list;
  }

    loadItens(int category) async{
    _itens = [];
    List result = await repository.loadItens(category);
    setState(() {
      result.forEach((item) {
        var item2 = new Item(
          item['nome'],
          item['categoria'],
          item['preco'],
          item['quantidade'],
          item['img'],
          item['_id'],
        );
        _itens.add(item2);
      });
    });
  }

  Widget _getListCategory(){

    ListView listCategory = new ListView.builder(
      itemCount: _categorys.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return _buildCategoryItem(index);
      }
    );

    return new Container(
      height: 55.0,
      child: listCategory,
    );
  }

  Widget _buildCategoryItem(index){
    return new GestureDetector(
      onTap: (){
        onTabCategory(index);
      },
      child: new Center(
        child: new Container(
          margin: new EdgeInsets.only(left: 0.4),
          child: new Material(
            child:  new Container(
              padding: new EdgeInsets.all(10.0),
              color: _category_selected == index ? Colors.blue[900]:Colors.blue[500],
              child: new Text(_categorys[index],
                style: new TextStyle(
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

  }

  onTabCategory(index) async {
    setState(() {
      _category_selected = index;
    });

    //Realiza chamada de serviço para atualizar as noticias de acordo com a categoria selecionada
    this.loadItens(_category_selected);
  }
}