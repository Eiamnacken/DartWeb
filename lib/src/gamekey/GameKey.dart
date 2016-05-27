import 'dart:io';
import 'dart:async';
import 'dart:convert' show UTF8, JSON;

/**
 *  Implementation of the client connection to the GameKey Server
 *
 */

/*
  Contains the GameKey REST API for BrickGame
 */
class GameKey{

  //Uri of the GameKey Service
  Uri _uri;

  //ID of the Game
  String _gameid;

  //Authenticate the Game
  String _secret;

 /*
    URI of GameKey REST API
  */
  Uri get uri => this._uri;

  /*
    Helper method to generate parameter body for REST requests
   */
  static String parameter(Map<String, String> p) => (new Uri(queryParameters: p)).query;

  //Constructor
  GameKey(String host, int port, this._gameid, this._secret){
    _uri = new Uri.http("$host:$port","/");
  }

  /*
    Registers a non existing user with the given name and password
    with the gamekey service
    Returns a map with the new registered users on succes
    Returns null on failure
   */
  Future<Map> registerUser(String name, String password) async{
    Map newUser = {
      "name":"$name",
      "pwd":"$password",
    };
    try {
      var client = await new HttpClient().post(uri.host, uri.port, "/user");
      client.write(parameter(newUser));
      HttpClientResponse response = await client.close();
      final body = JSON.decode( await response.transform(UTF8.decoder).join("\n"));
      if (response.statusCode == 200) return body;
    } catch (error, stacktrace) {
      print ("GameKey.registerUser() caused following error: '$error'");
      return null;
    }
  }

  /*
    Returns a map with all information about a user
    Returns null on failure
   */
  Future<Map> getUser(String id, String password) async{
    return null;
  }

  /*
    This method can be used to authenticate the current user
    and to check weather the gamekey service
    is available or not
   */
  Future<bool> authenticate() async{
    Future<bool> avbl;

    return null;
  }

  /*
    Returns the user id of the given name
    Returns null on failure
   */
  Future<String> getUserId(String name) async{
    return null;
  }

  /*
    Returns a JSON list with all registered
    users with the gamekey service
    Returns null on failure
   */
  Future<List<Map>> listUsers() async{
    return null;
  }

  /*
    Returns a JSON list with all stored states for this game
   */
  Future<List<Map>> getStates() async{
    return null;
  }

  /*
    Returns a JSON list with the saved states of this user
   */
  Future<List<Map>> storeState(String id, Map state) async{
    return null;
  }
}