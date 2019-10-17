import 'dart:ffi';

import 'package:http/http.dart' as http; 
import 'dart:async';
import 'dart:convert';

class Service {

  Future <List> loadItens(int category) async{
    String selection = '';

    if (category == 0)
      selection = 'TVs';
    else if (category == 1)
      selection = 'Celular';
    else if (category == 2)
      selection = 'Videogame';
    else if (category == 3)
      selection = 'Eletrodomestico';
    
    String url = "https://naja-codex.herokuapp.com/item/categoria?categoria=$selection";
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response
    try{
      http.Response response = await http.get(url,
      headers: {
        "Accept": "application/json"
      });
      // Using the JSON class to decode the JSON String
      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);
    } on Exception catch(_){
      return null;
    }
  }

  Future removeItem(String id) async{
    String url = "https://naja-codex.herokuapp.com/item/?id=$id";
     try{
      await http.delete(url, 
      headers: {
        "Accept": "application/json"
      });
    } on Exception catch(_){
      return null;
    }
  }

  Future cadastrarItem( String nome, String categoria, String preco, String quantidade, String img) async {
    String url = "https://naja-codex.herokuapp.com/item";

    Map data = { "nome": nome, "categoria": categoria, "preco": preco, "quantidade": quantidade, "img": img };

    var body = json.encode(data);
    print(body);

    await http.post(url,
       body: body,
       headers: {
        "Content-Type": "application/json"
      });
  }	
}