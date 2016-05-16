part of DartWeb;
/**
 *  Implementation of the client GameKey REST API in Dart
 *  by Markus Krebs
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

  //Constructor
  GameKey(String host, int port, String gameid, String secret){
    _uri = new Uri.http("$host:$port","/");
  }

  /*
    Registers a non existing user with the given name and password
    with the gamekey service
    Returns a map with all registered users on succes
    Returns null on failure
   */
  Future<Map> registerUser(String name, String password) async{

  }

  /*
    Returns a map with all information about a user
    Returns null on failure
   */
  Future<Map> getUser(String id, String password) async{

  }

  /*
    This method can be used to authenticate the current user
    and to check weather the gamekey service
    is available or not
   */
  Future<bool> authenticate() async{
    bool avbl=false;

    returns avbl;
  }

  /*
    Returns the user id of the given name
    Returns null on failure
   */
  Future<String> getUserId(String name) async{

  }

  /*
    Returns a JSON list with all registered
    users with the gamekey service
    Returns null on failure
   */
  Future<List<Map>> listUsers() async{

  }

  /*
    Returns a JSON list with all stored states for this game
   */
  Future<List<Map>> getStates() async{

  }

  /*
    Returns a JSON list with the saved states of this user
   */
  Future<List<Map>> storeState(String id, Map state) async{

  }
}