import 'dart:isolate';
import 'package:DartWeb/BrickGame.dart';
import 'package:test/test.dart';


List<List<GameObject>> gameField;



ReceivePort addPort=new ReceivePort();
ReceivePort getPort=new ReceivePort();
SendPort send;

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

main(){

  Field field = new Field(10,10);
  ReceivePort port = new ReceivePort();
  Ball ball;
  SendPort send;
  port.listen((msg){
    if(msg is SendPort){
      send=msg;
    }else if(msg is Ball){
      ball=msg;
    }
  });

  test("Teste objekte hinzufügen",(){
    Isolate.spawn(add,port.sendPort).then((isolate){
      send.send(new Ball(2,3,1,1,1));
    });
  });

  test("Teste objekte holen",(){
    Isolate.spawn(get,port.sendPort).then((isolate){
      send.send({"X":2,"Y":3});
      expect(ball,equals(new Ball(2,2,1,1,1)));
    });
  });


}