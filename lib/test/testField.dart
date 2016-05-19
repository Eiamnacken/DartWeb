import 'package:DartWeb/src/model/Field.dart';
import 'dart:isolate';
import 'package:test/test.dart';
import 'package:DartWeb/BrickGame.dart';


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
    Isolate.spawn(field.add,port.sendPort).then((isolate){
      send.send(new Ball(2,3,1,1,1));
    });
  });

  test("Teste objekte holen",(){
    Isolate.spawn(field.get,port.sendPort).then((isolate){
      send.send({"X":2,"Y":3});
      print(ball);
    });
  });


}