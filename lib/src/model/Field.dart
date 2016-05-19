import 'dart:isolate';
import 'package:DartWeb/BrickGame.dart';







class Field{

  List<List<GameObject>> gameField;

  static Field _cache;

  ReceivePort addPort;
  ReceivePort getPort;
  SendPort send;

  factory Field(int length,int heigth){
    if(_cache==null){
      _cache = new Field.newField(length,heigth);
      return _cache;
    }else {
      return _cache;
    }
  }

  Field.newField(int length,int heigth){
    List buffer = new List(length);
    buffer.forEach((list)=>list=new List<GameObject>(heigth));
    gameField=buffer;
    addPort = new ReceivePort();
    getPort = new ReceivePort();
  }

  void add(SendPort sendPort){
    sendPort.send(addPort.sendPort);

    addPort.listen((msg){
      if(msg is GameObject){
        gameField[msg.xPosition][msg.yPosition]=msg;
      }else if(msg is SendPort){
        sendPort.send(addPort.sendPort);
      }else return;
    });
  }

  void get(SendPort port){
    port.send(getPort.sendPort);

    getPort.listen((msg){
      if(msg is Map){
        port.send(gameField[msg["X"]][msg["Y"]]);
      }else if(msg is SendPort){
        port.send(getPort.sendPort);
      }

    });
  }







}