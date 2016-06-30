import 'dart:isolate';
import 'package:DartWeb/BrickGame.dart';
import 'package:test/test.dart';
import 'package:DartWeb/src/gamekey/GameKey.dart';
import 'dart:async';
import 'dart:html';


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
/*
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


}*/

//Just for testing till class gamekeyserver
main() async {
  //GameKeyServer apfel = await new GameKeyServer("127.0.0.1", 4000);

  // pause(const Duration(milliseconds: 500));

  //client();

  GameKey test = new GameKey("212.201.22.169",50001);
  //GameKey test = new GameKey("127.0.0.1", 4000);

  Future<Map> registergame = test.registerGame(
      "DontWorryAboutaThing", "BrickGame");
  registergame.then((content) {
    print(content);
  });

  Future<Map> registereduser = test.registerUser("aa", "dasdsads");
  registereduser.then((content) {
    print(content);
  });

  Future<Map> getUser = test.getUser("aan", "dasdsads");
  getUser.then((content) {
    print(content);
  });

  Future<List> getUsers = test.listUsers();
  getUsers.then((content) {
    print(content);
  });

  Future<List> getGames = test.listGames();
  getGames.then((content) {
    print(content);
  });

  Future<String> getUserId = test.getUserId("aan");
  getUserId.then((content) {
    print(content);
  });

  final state = {
    'state':"50"
  };
  Future<bool> storestate = test.storeState("791781819",state);
  storestate.then((content) {
    print(content);
  });

  Future<List> getstates = test.getStates();
  getstates.then((content) {
    print(content);
  });

  Future<bool> authenticate = test.authenticate();
  authenticate.then((content) {
    print(content);
  });
}
