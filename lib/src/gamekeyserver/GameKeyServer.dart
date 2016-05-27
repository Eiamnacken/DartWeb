//part of DartWeb;
import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:convert' show UTF8, JSON;
import 'package:DartWeb/src/gamekey/GameKey.dart';

/**
 *  Implementation of GameKey Server REST API in Dart
 *
 */

/*
  TOP-Level Method because of handling the Isolates
 */
/*
void handleIsolates(SendPort initialReplyTo){

  var port = new ReceivePort();
  initialReplyTo.send(port.sendPort);
  port.listen((msg) {
    var data = msg[0];
    SendPort replyTo = msg[1];
    replyTo.send(msg[1]);
    if (data == "close") { replyTo.send("closedreal");port.close(); }
  });

}
*/
//Just for testing till class gamekeyserver
main() async{
  /*GameKeyServer apfel = new GameKeyServer("127.0.0.1",4000);

  pause(const Duration(milliseconds: 500));

  client();*/
  GameKey test = new GameKey("212.201.22.161", 50001, "60", "test");
  Future<Map> registereduser = test.registerUser("anaaaaaa","dasdsadsadsadasdas");
  registereduser.then((content) {
    print(content);
  });
}

Future pause(Duration d) => new Future.delayed(d);

client() async{

  Uri client = new Uri.http("localhost:4000","/");
  client.resolve("/user");
  Map jsonData = {
    "name":"ananana",
    "password":"titten58",
  };

  var request = await new HttpClient().post(
      "127.0.0.1", 4000, '/user');
  request.headers.contentType = ContentType.parse('application/x-www-form-urlencoded');
  request.write(JSON.encode(jsonData));
  HttpClientResponse response = await request.close();
  await for (var contents in response.transform(UTF8.decoder)) {
    print(contents);
  }
}

/*
  This server handles the GameKey Service
 */
class GameKeyServer {

  //holding the server
  HttpServer server;

  //Holding all registered user
  Map allUser;

  //Holding all registered games
  Map allGames;

  //Holding all registered highscores
  Map allHighscores;

  //Holding the uri of the server
  Uri _uri;

  /*
    Returns the Uri of the server
   */
  Uri get getUri => this._uri;

  /*
    Returns a map with all registered User
   */
  Map get getallUser => this.allUser;

  /*
    Returns a map with all registered Games
   */
  Map get getallGames => this.allGames;

  /*
    Returns a map with all registered Highscores
   */
  Map get getallHighscores => this.allHighscores;

  //void set setAllUser(Map newUser) => this.allUser.addAll(newUser);

  /*
    Constructor
    - read all registered user from textfile
    - read all registered games from textfile
    - read all registered highscores from textfile
    - set up the server and waiting for clients
   */
  GameKeyServer(String host, int port){
    this._uri = new Uri.http("$host:$port", "/");


    readConfig();
    print("Config loaded ...");
    pause(const Duration(milliseconds: 400));

    initServer(host, port);
    print("Server running on ");
    print(getUri);
    pause(const Duration(milliseconds: 400));

    print("List of all User :");
    print(getallUser);

  }

  /*
    Read all registered users, games and highscores from textfile
   */
  readConfig(){
    try {
      //TODO brings to work that it handle a list of user
      var memoryuser = new File("memoryofallusers.txt").readAsStringSync();
      var memorygames = new File("memoryofallgames.txt").readAsStringSync();
      var memoryhighscores = new File("memoryofallhighscores.txt").readAsStringSync();
      allUser = JSON.decode(memoryuser);
      allGames = JSON.decode(memorygames);
      allHighscores = JSON.decode(memoryhighscores);
    } catch(e){
      print("Config could not read. " + e.toString());
      exit(1);
    }
  }

  /*
    Update all txt files with the new registered users, games and highscores
   */
  bool updateConfig() {
    try {
      //allUser.addAll(newMemory);
      var memoryusers = new File("memoryofallusers.txt");
      var memorygames = new File("memoryofallgames.txt");
      var memoryhighscores = new File("memoryofallhighscores.txt");
      memoryusers.writeAsStringSync(JSON.encode(getallUser));
      memorygames.writeAsStringSync(JSON.encode(getallGames));
      memoryhighscores.writeAsStringSync(JSON.encode(getallHighscores));
      return true;
    } catch (exception, stackTrace) {
      print("Could not update the config.");
      print(exception);
      print(stackTrace);
      return false;
    }
  }

  /*
    Method to initialize the server on the given host and port
    After that the server will listen on that host and port
   */
  initServer(String host, int port) async{
    try{
      //binds the server on given host and port
      this.server = await HttpServer.bind(host,port);
      //the server waits for incoming messages to handle
      await for (var Httpreq in server) {
        HttpResponse response = Httpreq.response;
        enableCors(response);
        handleMessages(Httpreq);

        /*
        //var httpRequest = [Httpreq.method, Httpreq.headers.contentType,
        //                  Httpreq.headers.contentType.mimeType];
        //var test = Httpreq.toList();
        //print(test);
        //var response = new ReceivePort();
        //ReceivePort response = new ReceivePort();
        //port.send([msg, response.sendPort]);

        ///Isolates replace Threads in Dart
        Future<Isolate> remote = Isolate.spawn(
            handleIsolates, response.sendPort);
        remote.then((_) => response.first).then((sendPort) {
          sendReceive(sendPort, "close").then((msg) {
            print("received: $msg");
            return sendReceive(sendPort, "close");
          }).then((msg) {
            print("received another: $msg");
          });
        });
        */

      }
    } catch (exception, stackTrace) {
      print("Server could not start. ");
      print(exception);
      print(stackTrace);
      exit(1);
    }
  }

  /*
    This method will send messages between the Isolates
   */
  /*
  Future sendReceive(SendPort port, msg) {
    ReceivePort response = new ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
  */

  /*
    Sets CORS headers for responses
   */
  void enableCors(HttpResponse response) {
    response.headers.add(
        "Access-Control-Allow-Origin",
        "*"
    );
    response.headers.add(
        "Access-Control-Allow-Methods",
        "POST, GET, DELETE, PUT, OPTIONS"
    );
    response.headers.add(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept, Charset"
    );
  }

  /*
    All incoming messages from the client handles this method
    //- called only by 'handleIsolates()'
    //- Returns a string of what kind of messages came in
   */
  handleMessages(HttpRequest msg) async {
    //which request is it ? ...

    //Request for add an user
    if (msg.method == 'POST'  && msg.uri.toString() == '/user' &&
        msg.headers.contentType != null && msg.headers.contentType.mimeType == 'application/x-www-form-urlencoded') {
      try {
        Map jsonData = JSON.decode(await msg.transform(UTF8.decoder).join());
        if (addUser(jsonData)) {
          msg.response
            ..statusCode = HttpStatus.OK
            ..write(getallUser)
            ..close();
        } else {
          msg.response
            ..statusCode = HttpStatus.CONFLICT
            ..write("Some User mind exist with that name and password")
            ..close();
        }
      } catch (e) {
        msg.response
          ..statusCode = HttpStatus.INTERNAL_SERVER_ERROR
          ..close();
      }
    } else {
      msg.response
        ..statusCode = HttpStatus.METHOD_NOT_ALLOWED
        ..write("Unsupported request: ${msg.method}.")
        ..close();
    }
  }



  //TODO
  /*
    Remove a registered user
   */
  removeUser(Map o){
    allUser.remove(o);
    updateConfig();
  }

  //TODO
  /*
    Generate a gameid and userid and add the user to the map
   */
  bool addUser(Map o){
    if(!allUser.containsKey(o['name'])&&!allUser.containsValue(o['password'])){
      allUser.addAll(o);
      updateConfig();
      return true;
    } else {
      return false;
    }
  }

  int generateGameID(String name, String password, String secret){
    return 0;
  }

  /*
    This method generates a new user id
    - it will only called by 'addUser'
   */
  int generateUserID(){

  }

  /*
    Save all updates to textfile and close the program
   */
  closeTheServer() async{
    if (updateConfig()) exit(1);
    else {
      print("Error at closing the server.");
      exit(1);
    }
  }
}