import 'dart:io';
import 'dart:async';

/**
 *  Implementation of GameKey server REST API in Dart
 *  by Markus Krebs
 */

//Just for testing till class gamekeyserver
import 'dart:convert' show UTF8, JSON;


main(){
  gamekeyserver apfel = new gamekeyserver("localhost",4000);

  pause(const Duration(milliseconds: 500));

  client();
}

Future pause(Duration d) => new Future.delayed(d);

client() async{
  Uri client = new Uri.http("localhost:4000","/");
  Map jsonData = {
    'name':     'Africa',
  };

  var request = await new HttpClient().post(
      "127.0.0.1", 4000, '/test.txt');
  request.headers.contentType = ContentType.JSON;
  request.write(JSON.encode(jsonData));
  HttpClientResponse response = await request.close();
  await for (var contents in response.transform(UTF8.decoder)) {
    print(contents);
  }
}

/*
  This server handles the GameKey Service
 */
class gamekeyserver {

  HttpServer _server;

  //TODO Create a class User
  Map<User> _allUser;

  /*
    Returns a map with all User
   */
  Map get allUser => this._allUser;

  /*
    Constructor
   */
  gamekeyserver(String host, int port){
    try {
      readConfig();
      pause(const Duration(milliseconds: 400));

      initServer(host, port);
      pause(const Duration(milliseconds: 400));

      letItRun();
      print(_allUser.values);
    }catch(e){
      print (e);
    }
  }

  /*
    Read all registered users from textfile
   */
  readConfig(){
    try {
      var memory = new File("memoryofalluser.txt"); //
      var data = memory.readAsStringSync();
      this._allUser = JSON.decode(data);
      print("Config loaded ...");
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
      this._server = await HttpServer.bind(host,port);
      print("Server running on ${server.address}:${server.port}");
    } catch (e) {
      print("Server could not start. " + e.toString());
    }
  }

  /*
    The gamekey server waits for incoming messages to handle it
   */
  letItRun() async{
    try {
      await for (var Httpreq in _server) {
        var cT = Httpreq.headers.contenType;
        handleMessage(Httpreq, cT);
      }
    } catch (e){
      print("Something went with the incoming messages wrong. " + e.toString());
    }
  }

  /*
    This method will handle the incoming messages from the client
   */
  handleMessage(HttpRequest msg, ContentType ct) async{
    if (msg.method == 'POST' && ct != null && ct.mimeType == 'application/json') {
      try {
        var jsonString = await msg.transform(UTF8.decoder).join();

        // Write to a file, get the file name from the URI.
        var filename = msg.uri.pathSegments.last;
        await new File(filename).writeAsString(jsonString, mode: FileMode.WRITE);
        Map jsonData = JSON.decode(jsonString);
        msg.response..statusCode = HttpStatus.OK
          ..write('Wrote data for ${jsonData['name']}.')
          ..close();
      } catch (e) {
        msg.response..statusCode = HttpStatus.INTERNAL_SERVER_ERROR
          ..close();
      }
    } else {
      msg.response..statusCode = HttpStatus.METHOD_NOT_ALLOWED
        //..write("Unsupported request: ${msg.method}.")
        ..close();
      //_server.close();
    }
  }

}