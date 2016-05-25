//part of DartWeb;
import 'dart:io';
import 'dart:async';
import 'package:DartWeb/src/gamekeyserver/User.dart';

/**
 *  Implementation of GameKey Server REST API in Dart
 *
 */

//Just for testing till class gamekeyserver
import 'dart:convert' show UTF8, JSON;

main(){
  GameKeyServer apfel = new GameKeyServer("127.0.0.1",4000);

  pause(const Duration(milliseconds: 500));

  client();
}

Future pause(Duration d) => new Future.delayed(d);

client() async{

  //Uri client = new Uri.http("localhost:4000","/");
  Map jsonData = {
    "1":["anana","titten","titten01","50"],
  };


  var request = await new HttpClient().post(
      "127.0.0.1", 4000, '/test.txt');
  request.headers.contentType = ContentType.JSON;
  request.write(JSON.encode(jsonData));
  request.close();

}

/*
  This server handles the GameKey Service
 */
class GameKeyServer {

  //holding the server
  HttpServer server;

  //Holding all registered user
  Map allUser;

  //Holding the uri of the server
  Uri _uri;

  /*
    Returns
   */
  Uri get getUri => this._uri;

  /*
    Returns a map with all registered User
   */
  Map get getallUser => this.allUser;

  /*
    Constructor
    - read all registered user from textfile
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
    pause(const Duration(milliseconds: 700));

    print("List of all User :");
    print(getallUser);

  }

  /*
    Read all registered users from textfile
   */
  readConfig(){
    try {
      //TODO brings to work that it handle a list of user
      var memory = new File("memoryofalluser.txt").readAsStringSync(); //
      allUser=JSON.decode(memory);
    } catch(e){
      print("Config could not read. " + e.toString());
      exit(1);
    }
  }

  /*
    Method to initialize the server on the given host and port
    After that the server will listen on that host and port
   */
  initServer(String host, int port) async{
    try{
      //bind the server on given host and port
      this.server = await HttpServer.bind(host,port);
      //the server waits for incoming messages to handle
      await for (var Httpreq in server) {
        var cT = Httpreq.headers.contentType;
        handleMessage(Httpreq, cT);
      }
    } catch (exception, stackTrace) {
      print("Server could not start. ");
      print(exception);
      print(stackTrace);
      exit(1);
    }
  }

  /*
    Update the memoryofalluser file with the new registered user
   */
  bool updateConfig() {
    try {
      var memory = new File("memoryofalluser.txt");
      memory.writeAsStringSync(JSON.encode(getallUser));
      return true;
    } catch (exception, stackTrace) {
      print("Could not update the config.");
      print(exception);
      print(stackTrace);
    }
  }

  /*
    This method will handle the incoming messages from the client
   */
  handleMessage(HttpRequest msg, ContentType ct) async{

    //which request is it ? ...
    if (msg.method == 'POST' && ct != null && ct.mimeType == 'application/json') {

      try {
        var jsonString = await msg.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);
        allUser.addAll(jsonData);
        //updateConfig();
        msg.response..statusCode = HttpStatus.OK
          ..write("Wrote data for ${jsonData['user']}.")
          ..close();
      } catch (e) {
        msg.response..statusCode = HttpStatus.INTERNAL_SERVER_ERROR
          ..close();
      }

    } else {
      msg.response..statusCode = HttpStatus.METHOD_NOT_ALLOWED
        ..write("Unsupported request: ${msg.method}.")
        ..close();
      closeTheServer();
    }
  }

  //TODO
  /*
    Remove a registered user
   */
  removeUser(Object o){
    allUser.remove(o);
  }

  //TODO
  /*
    Generate a gameid and add the user to the map
   */
  addUser(Object o){

  }

  int generateGameID(String name, String password,String secret){
    return 0;
  }

  /*
    Save all registered user to textfile and close the program
   */
  closeTheServer(){
    updateConfig();
    exit(1);
  }

}