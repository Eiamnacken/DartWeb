import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:convert' show UTF8, JSON;
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:DartWeb/src/gamekey/GameKey.dart';
import 'dart:core';

/**
 *  Implementation of GameKey Server REST API in Dart
 *  by Markus Krebs
 */

/*
  TOP-Level Method: handling the Isolates
  NOTE: Not in use because it is not possible to send a HttpRequest over to an Isolate
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
main() async {
  GameKeyServer apfel = await new GameKeyServer("127.0.0.1", 4000);

  pause(const Duration(milliseconds: 500));

  //client();

  //GameKey test = new GameKey("212.201.22.161", 50001);
  GameKey test = new GameKey("127.0.0.1", 4000);

  Future<Map> registergame = test.registerGame(
      "DontWorryAboutaThing", "BrickGame");
  registergame.then((content) {
    print(content);
  });

  Future<Map> registereduser = test.registerUser("aa", "dasdsads");
  pause(const Duration(milliseconds: 500));
  registereduser.then((content) {
    print(content);
  });

  pause(const Duration(milliseconds: 500));
  Future<Map> getUser = test.getUser("aan", "dasdsads");
  getUser.then((content) {
    print(content);
  });

  pause(const Duration(milliseconds: 500));
  Future<List> getUsers = test.listUsers();
  getUsers.then((content) {
    print(content);
  });

  pause(const Duration(milliseconds: 500));
  Future<List> getGames = test.listGames();
  getGames.then((content) {
    print(content);
  });
/*
  pause(const Duration(milliseconds: 500));
  Future<String> getUserId = test.getUserId("aan");
  getUserId.then((content) {
    print(content);
  });
    */


  pause(const Duration(milliseconds: 500));
  final state = {
    'state':"50"
  };
  Future<bool> storestate = test.storeState("791781819",state);
  storestate.then((content) {
    print(content);
  });

  pause(const Duration(milliseconds: 500));
  Future<List> getstates = test.getStates();
  getstates.then((content) {
    print(content);
  });
/*
  pause(const Duration(milliseconds: 500));
  Future<bool> authenticate = test.authenticate();
  authenticate.then((content) {
    print(content);
  });*/

}

Future pause(Duration d) => new Future.delayed(d);

client() async {
  Map jsonData = {
    "pwd":"dasdsads",
  };
  //String json = "name=ananana&pwd=apfel";
  Uri uri = new Uri.http("127.0.0.1:4000", "/");
  final link = uri.resolve("/user/432081610").resolveUri(
      new Uri(queryParameters: {'id':"432081610"}));
  var request = await new HttpClient().deleteUrl(link);
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

  //Holding all registered user since register
  List textfileUsers;

  //Holding all registered games since register
  List textfileGames;

  //Holding all registered gamestates since register
  List textfileGamestates;

  //Holding the uri of the server
  Uri _uri;

  /*
    Returns the Uri of the server
   */
  Uri get getUri => this._uri;

  /*
    Returns a list with all registered User
   */
  List get gettextfileUsers => this.textfileUsers;

  /*
    Returns a list with all registered Games
   */
  List get gettextfileGames => this.textfileGames;

  /*
    Returns a list with all registered gamestsates
   */
  List get gettextfileGamestates => this.textfileGamestates;

  /*
    Constructor
    - read all registered user from textfile
    - read all registered games from textfile
    - read all registered gamestates from textfile
    - set up the server and waiting for clients
   */
  GameKeyServer(String host, int port) {
    this._uri = new Uri.http("$host:$port", "/");
    initServer(host, port);
    print("Server running on ... ${getUri.toString()}");
  }

  /*
    Read all registered users, games and gamestates from textfile
    - these textfiles have to exist in the root file of the project although
      they have to be in JSON format, at least "{}"
   */
  Future<bool> readConfig() async {
    try {
      var memoryuser = new File("memoryofallusers.json").readAsStringSync();
      var memorygames = new File("memoryofallgames.json").readAsStringSync();
      var memorygamestates = new File("memoryofallgamestates.json")
          .readAsStringSync();
      textfileUsers = JSON.decode(memoryuser);
      textfileGames = JSON.decode(memorygames);
      textfileGamestates = JSON.decode(memorygamestates);
      return true;
    } catch (error, stacktrace) {
      print("Config could not read. " + error);
      print(stacktrace);
      exit(1);
    }
  }

  /*
    Update all txt files with the new registered users, games and gamestates
    - i Which List was updated (0=user,1=games,2=gamestates)
   */
  Future<bool> updateConfig(int i, [List listtoupdate]) async {
    try {
      switch (i) {
        case 0:
          final writeuser = new File("memoryofallusers.json");
          writeuser.writeAsStringSync(JSON.encode(gettextfileUsers));
          return true;
        case 1:
          final writegames = new File("memoryofallgames.json");
          writegames.writeAsStringSync(JSON.encode(gettextfileGames));
          return true;
        case 2:
          final writegamestates = new File("memoryofallgamestates.json");
          writegamestates.writeAsStringSync(JSON.encode(gettextfileGamestates));
          return true;
      }
      return false;
    } catch (error, stacktrace) {
      print("Could not update the config.");
      print(error);
      print(stacktrace);
      return false;
    }
  }

  /*
    Method to initialize the server on the given host and port
    After initialization the server will listen on the same host and port for incoming requests
   */
  initServer(String host, int port) async {
    if (await readConfig()) {
      print("Config loaded ...");
      print("All existing User: ${gettextfileUsers}");
    }

    try {
      //binds the server on given host and port
      this.server = await HttpServer.bind(host, port);
      //the server waits for incoming requests to handle
      await for (var Httpreq in server) {
        enableCors(Httpreq.response);
        var ishandled = await handleMessages(Httpreq);
        if (ishandled == 1) {
          if (await updateConfig(0) && await updateConfig(1) &&
              await updateConfig(2)) {}
          Httpreq.response.close();
        }

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
      await closeTheServer();
    } catch (error, stacktrace) {
      print("Server could not start.");
      print(error);
      print(stacktrace);
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
    Sets CORS headers for response
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
    All incoming requests will be handled here
    //- called only by 'handleIsolates()'
    //- Returns a string of what kind of messages came in
   */
  Future<int> handleMessages(HttpRequest msg) async {
    try {
      //body of incomming message
      var msg1 = await msg.transform(UTF8.decoder).join();
      var parameter = await Uri
          .parse("?$msg1")
          .queryParameters;

      //which request is it ? ...

      //Request for create an user
      RegExp postuser = new RegExp("/user");
      if (msg.method == 'POST' && (postuser.hasMatch(msg.requestedUri.path)|| msg.requestedUri.path == '//user')) {
        final name = parameter["name"];
        final password = parameter["pwd"];
        final mail = parameter["mail"];
        if (name != null && password != null) {
          Map newuser = await addUser(name, password, mail);
          if (newuser != null) {
            msg.response
              ..statusCode = 200
              ..write(JSON.encode(newuser));
            return 1;
          } else {
            msg.response
              ..statusCode = 409
              ..write("Some User might exist with that name.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 400
            ..write("Name and password must be set.");
          return 1;
        }
      }
      //Request for get a user
      RegExp user = new RegExp(r'/user/(\w+)\/?');
      if (msg.method == 'GET' && user.hasMatch(msg.requestedUri.path)) {
       // RegExp user = new RegExp(r'(\w+)\/?');
        final id = user.stringMatch(msg.requestedUri.path);
        final password = msg.requestedUri.queryParametersAll["pwd"];

        bool byname = false;

        if (msg.requestedUri.queryParametersAll["byname"][0].toString() == "true")
          byname = true;
        print("-------------to debug 2222");
        print(" $id $password $byname");
        Map getuser = await getUser(id, password, byname);

        if (id != null && password != null) {
          if (getuser != null) {

            if (getuser.length > 0) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(getuser));
              return 1;
            } else {
              msg.response
                ..statusCode = 404
                ..write("Authentication problem, check ID and Password.");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("No existing game with that id.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 404
            ..write("ID and Password must be set.");
          return 1;
        }
      }
      //Request for delete an user && all stored gamestates
      RegExp removeuser = new RegExp(r'/user/(\d+)\/?');
      if (msg.method == 'DELETE' &&
          removeuser.hasMatch(msg.requestedUri.path)) {
        RegExp user = new RegExp(r'(\d+)\/?');

        final password = parameter["pwd"];
        final id = user.stringMatch(msg.requestedUri.path);
        bool remuser = await removeUser(id, password);
        if (id != null && password != null) {
          if (remuser != null) {
            if (remuser) {
              msg.response
                ..statusCode = 200
                ..write("User with id=$id was removed");
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write(
                    "Authentication problem, please check ID and Password.");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("No existing user with that id.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("ID and Password must be set.");
          return 1;
        }
      }

      //Request for get all users
      if (msg.method == 'GET' && (msg.requestedUri.path == '/users' ||
          msg.requestedUri.path == '//users')) {
        readConfig();
        msg.response
          ..statusCode = HttpStatus.OK
          ..write(JSON.encode(gettextfileUsers));
        return 1;
      }
      //Request for update an user
      RegExp updateuser = new RegExp(r'/user/(\d+)\/?');
      if (msg.method == 'PUT' && updateuser.hasMatch(msg.requestedUri.path)) {
        RegExp user = new RegExp(r'(\d+)\/?');
        final id = user.stringMatch(msg.requestedUri.path);
        final password = parameter["pwd"];
        final newpassword = parameter["newpwd"];
        final newname = parameter["name"];
        final newmail = parameter["mail"];
        Map updateduser = await updateUser(
            id, password, newname, newpassword, newmail);
        if (id != null && password != null) {
          if (updateduser != null) {
              if (updateduser.length>0) {
                msg.response
                  ..statusCode = 200
                  ..write(JSON.encode(updateduser));
                return 1;
              } else {
                msg.response
                    ..statusCode = 401
                    ..write("Authentication problem, check ID and Password");
                return 1;
              }
          } else {
            msg.response
              ..statusCode = 401
              ..write("No existing user with that id");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("ID and Password must be set.");
          return 1;
        }
      }

      //Request for create a game
      if (msg.method == 'POST' && msg.uri.path == '/game') {
        final name = parameter["name"];
        final secret = parameter["secret"];
        final uri = parameter["uri"];
        if (name != null && secret != null) {
          Map newgame = await addGame(name, secret, uri);
          if (newgame != null) {
            msg.response
              ..statusCode = HttpStatus.OK
              ..write(JSON.encode(newgame));
            return 1;
          } else {
            msg.response
              ..statusCode = 409
              ..write("Some Game might exist with that name.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 400
            ..write("Name and Secret must be set.");
          return 1;
        }
      }
      //Request for get a game
      RegExp getgame = new RegExp(r'/game/(\d+)\/?');
      if (msg.method == 'GET' && getgame.hasMatch(msg.requestedUri.path)) {
        RegExp game = new RegExp(r'(\d+)\/?');
        final id = game.stringMatch(msg.requestedUri.path);
        final password = parameter["secret"];
        Map getgame = await getGame(id, password);
        if (id != null && password != null) {
          if (getgame != null) {
            if (getgame.length > 0) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(getgame));
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write("Authentication problem, check ID and Password");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 404
              ..write("No existing game with that id.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("ID and Password must be set.");
          return 1;
        }
      }
      //Request for get all games
      if (msg.method == 'GET' && msg.uri.toString() == '/games') {
        await readConfig();
        msg.response
          ..statusCode = HttpStatus.OK
          ..write(JSON.encode(gettextfileGames));
        return 1;
      }
      //Request for update a game
      RegExp updategame = new RegExp(r'/game/(\d+)\/?');
      if (msg.method == 'PUT' && updategame.hasMatch(msg.requestedUri.path)) {
        RegExp game = new RegExp(r'(\d+)\/?');
        final id = game.stringMatch(msg.requestedUri.path);
        final password = parameter["secret"];
        final newpassword = parameter["newsecret"];
        final newname = parameter["name"];
        final newuri = parameter["url"];
        Map updatedgame = await updateGame(
            id, password, newname, newpassword, newuri);
        if (id != null && password != null) {
          if (updatedgame != null) {
            if (updatedgame.length > 0) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(updatedgame));
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write("No existing game with that id.");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("Authentication problem, please check ID and Password.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("ID and Password must be set.");
          return 1;
        }
      }
      //Request for delete a game
      RegExp removegame = new RegExp(r'/game/(\d+)\/?');
      if (msg.method == 'DELETE' &&
          removegame.hasMatch(msg.requestedUri.path)) {
        RegExp game = new RegExp(r'(\d+)\/?');
        final password = parameter["secret"];
        final id = game.stringMatch(msg.requestedUri.path);

        bool remgame = await removeGame(id, password);
        if (game != null) {
          if ((password.toString().contains("null") != true) &&
              (id.toString().contains("null") != true)) {
            if (remgame) {
              msg.response
                ..statusCode = 200
                ..write("Game with id=$id was removed");
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write(
                    "Authentication problem, please check ID and Password.");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("No existing game with that id.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("ID and Password must be set.");
          return 1;
        }
      }
      //Request for storing gamestate for a game and a user
      RegExp id = new RegExp(r'(\d+)\/?');
      RegExp postgamestate = new RegExp(r'/gamestate/(\d+)\/?/(\d+)\/?');
      if (msg.method == 'POST' &&
          postgamestate.hasMatch(msg.requestedUri.path)) {
        RegExp gameid = new RegExp(r'/(\d+)\/?/');
        RegExp userid = new RegExp(r'(\d+)\/?');
       // final password = parameter["secret"];
        var password = msg.requestedUri.queryParametersAll["secret"][0];
        var state = msg.requestedUri.queryParametersAll["state"][0];

        //final state = parameter["state"];
        final gid = msg.requestedUri.pathSegments[1];
        final uid = msg.requestedUri.pathSegments[2];

        if (gid != null && uid != null && password != null) {
          Map newgamestate = await addGameState(gid,uid,password,state);
          if (newgamestate.length>0) {
            if (newgamestate != null) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(newgamestate));
              return 1;
            } else {
              msg.response
                  ..statusCode = 401
                  ..write("No existing game or user with that id");
              return 1;
            }
          } else {
            msg.response
                ..statusCode = 401
                ..write("Authentication problem, please check ID and Password.");
            return 1;
          }
        }
        msg.response
          ..statusCode = 401
          ..write("Gameid, userid and password must be set.");
        return 1;
      }

      //Request for get a gamestore with given game and user
      RegExp getgsgamestate = new RegExp(r'/gamestate/(\d+)\/?/(\d+)\/?');
      if (msg.method == 'GET' && getgsgamestate.hasMatch(msg.requestedUri.path)) {
        final password = msg.requestedUri.queryParametersAll["secret"][0];
        final gid = msg.requestedUri.pathSegments[1];
        final uid = msg.requestedUri.pathSegments[2];
        if (gid != null && uid != null && password != null) {
          final getgamestate = await getGameState(gid,uid,password);
          if (getgamestate.length>0) {
            if (getgamestate != null) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(getgamestate));
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write("No existing game or user with that id");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("Authentication problem, please check ID and Password.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("Gameid, userid and password must be set.");
          return 1;
        }
      }

      //Request for get a gamestore with given game
      RegExp getggamestate = new RegExp(r'/gamestate/(\d+)\/?');
      if (msg.method == 'GET' && getggamestate.hasMatch(msg.requestedUri.path)) {
        final password = msg.requestedUri.queryParametersAll["secret"][0];
        final gid = msg.requestedUri.pathSegments[1];
        print("get params: ${msg.requestedUri.queryParametersAll} header params: ${msg.requestedUri.pathSegments}");
        print("--------------to debug");

        if (gid != null && password != null) {
          final getgamestate = await getGameStatewithGame(gid,password);
          if (getgamestate.length>0) {
            if (getgamestate != null) {
              msg.response
                ..statusCode = 200
                ..write(JSON.encode(getgamestate));
              return 1;
            } else {
              msg.response
                ..statusCode = 401
                ..write("No existing game or user with that id");
              return 1;
            }
          } else {
            msg.response
              ..statusCode = 401
              ..write("Authentication problem, please check ID and Password.");
            return 1;
          }
        } else {
          msg.response
            ..statusCode = 401
            ..write("Gameid, userid and password must be set.");
          return 1;
        }
      }

      msg.response.statusCode = 404;
      msg.response.write("Not found");
      return 1;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  /*
    Updates an user
    - returns the updated user on succes
    - return empty map on authentication problem
    - return null on finding none user with given id
   */
  Future<Map> updateUser(String id, password, newname, newpassword,
      newmail) async {
    Map emptymap = new Map();
    String oldsignature = BASE64
        .encode(sha256
        .convert(UTF8.encode("$id,$password"))
        .bytes);
    try {
      Map existinguser = gettextfileUsers.singleWhere((
          user) => user["signature"] == oldsignature);
      if (gettextfileUsers.any((user) => user['id'] == id)) {
        if (existinguser != null) {
          existinguser["name"] = newname;
          existinguser["pwd"] = newpassword;
          existinguser["signature"] = BASE64
              .encode(sha256
              .convert(UTF8.encode("$id,$newpassword"))
              .bytes);

          if (newmail != null && newmail
              .toString()
              .isNotEmpty)
            existinguser["mail"] = newmail;
          gettextfileUsers.removeWhere((user) => user['id'] == id);
          gettextfileUsers.add(existinguser);
          return existinguser;
        } else
          return null;
      } else
        return emptymap;
    } catch (error) {
      return null;
    }
  }

  /*
    Retrieves all data about an user
    - return user on succes
    - return empty map on authentication problem
    - return null on finding none user with given id
   */
  Future<Map> getUser(String id, password, bool byname) async {
    Map existinguser;
    Map emptymap = new Map();
    String signature = BASE64.encode(sha256
        .convert(UTF8.encode("$id,$password"))
        .bytes);
    try {
      if (byname == true) {
        existinguser = new Map.from(
            gettextfileUsers.firstWhere((user) => user["name"] == id));
      } else {
        existinguser = new Map.from(gettextfileUsers.firstWhere((user) => user["id"] == id));
      }
      if (existinguser != null) {
        if ((existinguser["signature"] == signature))
          return existinguser;
        else
          return emptymap;
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  /*
    Retrieves a gamestate stored for a game and a user
    - return gamestate on succes
    - returns empty map on authentication problem
    - return null on finding none user with given id
   */
  Future<List> getGameState(String gameid, userid, secret) async{
    List emptymap = new List();
    String signature = BASE64
        .encode(sha256
        .convert(UTF8.encode("$gameid,$secret"))
        .bytes);
    if (gettextfileGames.any((game) => game["id"] == gameid) &&
        gettextfileUsers.any((user) => user["id"] == userid)) {
      if (gettextfileGames.any((game) => game["id"] == gameid &&
          game["signature"] == signature)) {
        final gamestate = gettextfileGamestates.where(( gamestate) =>
          gamestate["gameid"] == gameid && gamestate["userid"] == userid);
        if (gamestate != null) {
          List allstates = gamestate.toList();
          //print(allstates);
          allstates.sort((a,b) => DateTime.parse(b["created"]).compareTo(DateTime.parse(a["created"])));
          //print(allstates);
          return allstates;
        }
      } else
        return emptymap;
    } else
      return null;
  }

  /*
    Retrieves a gamestate stored for a game
    - return gamestate on succes
    - returns empty map on authentication problem
    - return null on finding none gamestate with given id
   */
  Future<List> getGameStatewithGame(String gameid, secret) async{
    List emptymap = new List();
    String signature = BASE64
        .encode(sha256
        .convert(UTF8.encode("$gameid,$secret"))
        .bytes);
    if (gettextfileGames.any((game) => game["id"] == gameid)) {
      if (gettextfileGames.any((game) => game["id"] == gameid &&
          game["signature"] == signature)) {
        final gamestate = gettextfileGamestates.where(( gamestate) =>
        gamestate["gameid"] == gameid);
        if (gamestate != null) {
          List allstates = gamestate.toList();
          allstates.sort((a,b) => DateTime.parse(b["created"]).compareTo(DateTime.parse(a["created"])));
          return allstates;
        }
      } else
        return emptymap;
    } else
      return null;
  }

  /*
    Retrieves all data about a game
    - return game on succes
    - return empty map on authentication problem
    - return null on finding none user with given id
   */
  Future<Map> getGame(String id, password) async {
    Map emptymap = new Map();
    String signature = BASE64.encode(sha256
        .convert(UTF8.encode("$id,$password"))
        .bytes);
    try {
      Map existinggame = gettextfileGames.singleWhere((game) => game["id"] ==
          id);
      if (existinggame["signature"] == signature) {
        if (existinggame != null)
          return existinggame;
        else
          return null;
      } else
        return emptymap;
    } catch (error) {
      return null;
    }
  }

  /*
    Updates a game
    - returns the updated game on succes
    - returns null on authentication problem
    - if no user is stored with given id it returns an empty map
   */
  Future<Map> updateGame(String id, secret, newname, newsecret, newuri) async {
    Map emptymap = new Map();
    String oldsignature = BASE64
        .encode(sha256
        .convert(UTF8.encode("$id,$secret"))
        .bytes);
    try {
      Map existinggame = gettextfileGames.singleWhere((
          game) => game["signature"] == oldsignature);
      if (gettextfileGames.any((game) => game['id'] == id)) {
        if (existinggame != null) {
          existinggame["name"] = newname;
          //existinggame["users"] = new List();
          existinggame["pwd"] = newsecret;
          existinggame["signature"] = BASE64
              .encode(sha256
              .convert(UTF8.encode("$id,$newsecret"))
              .bytes);
          if (newuri != null && newuri
              .toString()
              .isNotEmpty)
            existinggame["url"] = newuri;
          gettextfileGames.removeWhere((game) => game['id'] == id);
          gettextfileGames.add(existinggame);
          return existinggame;
        } else
          return null;
      } else
        return emptymap;
    } catch (error) {
      return null;
    }
  }

  /*
    Store a gamestate for a game and a user
    - returns the current stored gamestate on succes
    - returns an empty map on authentication problem
    - returns null on finding none game or user
   */
  Future<Map> addGameState(String gameid, userid, secret, String state) async {
    Map emptymap = new Map();
    String signature = BASE64
        .encode(sha256
        .convert(UTF8.encode("$gameid,$secret"))
        .bytes);
    if (gettextfileGames.any((game) => game["id"] == gameid) &&
        gettextfileUsers.any((user) => user["id"] == userid)) {
      if (gettextfileGames.any((game) => game["id"] == gameid &&
          game["signature"] == signature)) {
        final nameofgame = gettextfileGames.firstWhere((game) => game["id"] == gameid)["name"];
        final nameofuser = gettextfileUsers.firstWhere((user) => user["id"] == userid)["name"];
        Map newstate = {
          "type":"gamestate",
          "gamename":"$nameofgame",
          "username":"$nameofuser",
          "gameid":"$gameid",
          "userid":"$userid",
          "created":"${new DateTime.now().toUtc().toIso8601String()}",
          "state":"${JSON.decode(state)}"
        };
        textfileGamestates.add(newstate);
        return newstate;
      } else {
        return emptymap;
      }
    }
  }

  /*
    Register a game
    - returns the current registered game on success
    - returns null  on failure
   */
  Future<Map> addGame(String name, secret, uri) async
  {
    bool isinList = gettextfileGames.any((game) => game["name"] == "$name");
    gettextfileGames.forEach((game) {
      if (game['name'] == name) {
        isinList = true;
      }
    });
    if (!isinList) {
      final id = new Random.secure().hashCode.toString();
      Map newgame = {
        // "users":"",
        "type":"game",
        "name":"$name",
        "id":"$id",
        "url":"",
        "created":"${new DateTime.now().toUtc().toIso8601String()}",
        "signature":"${BASE64
            .encode(sha256
            .convert(UTF8.encode("$id,$secret"))
            .bytes)}"
      };
      if (gettextfileGamestates.length>2) {
        newgame["users"] = new List();
        gettextfileGamestates.forEach((gamestate) {
          if (gamestate["gameid"] == id) {
            newgame["users"].add(gamestate["userid"]);
          }
        });
      }
     /* for (List lists in gettextfileGamestates) {
        for (Map gamestate in lists) {
          if (gamestate["gameid"] == id) {
            print(gamestate);
            newgame["users"]=new List();
            newgame["users"].add(gamestate["userid"]);
          }
        }
      }*/
      gettextfileGames.add(newgame);
      return newgame;
    } else
      return null;
  }

  /*
    Remove a registered user and all registered highscores for that user
    - returns true on success
    - returns false on unauthorized
    - returns null on no existing user with given id
   */
  Future<bool> removeUser(String id, password) async {
    //TODO remove all highscores from that user
    try {
      Map user = gettextfileUsers.firstWhere((user) => user["id"] == id);
      String signature = BASE64
          .encode(sha256
          .convert(UTF8.encode("$id,$password"))
          .bytes);
      if (gettextfileUsers.any((user) => user["id"] == id)) {
        Map user = gettextfileUsers.firstWhere((user) => user["id"] == id);
        if (user != null) {
          if (user["signature"] == signature) {
            if(gettextfileUsers.remove(user))
              return true;
            else
              return false;
          }
          return null;
        }
        return false;
      }
      return false;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return false;
    }
  }

  /*
    Remove a registered game and all registered highscores for that game
    - returns true on success
    - returns false on unauthorized
    - returns null on no existing user with given id
   */
  Future<bool> removeGame(String id, password) async {
    //TODO remove all highscores from that game
    try {
      Map game = gettextfileGames.singleWhere((game) => game["id"] == id);
      String signature = BASE64
          .encode(sha256
          .convert(UTF8.encode("$id,$password"))
          .bytes);

      if (game["signature"] == signature) {
        if (gettextfileGames.any((game) => game["id"] == id)) {
          gettextfileUsers.removeWhere((game) => game["id"] == id);
          return true;
        }
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return false;
    }
  }

  /*
    Register an user
    - returns the current registered user on success
    - returns null  on failure
   */
  Future<Map> addUser(String name, password, mail) async {
    bool isinList = false;

    for (int i = 0; i < gettextfileUsers.length; i++) {
      if (gettextfileUsers[i]["name"] == "$name") {
        isinList = true;
      }
    }
    if (!isinList) {
      final id = new Random.secure().hashCode.toString();
      Map newuser = {
        "type":"user",
        "name":"$name",
        "pwd" :"$password",
        "id":"$id",
        "created":"${new DateTime.now().toUtc().toIso8601String()}",
        "signature":"${BASE64
            .encode(sha256
            .convert(UTF8.encode("$id,$password"))
            .bytes)}"
      };
      gettextfileUsers.add(newuser);
      return newuser;
    } else
      return null;
  }

  /*
    Save all updates to textfile and close the server
    - only calls once after awaits for incoming messages from client
   */
  closeTheServer() async {
    if (await updateConfig(0) && await updateConfig(1) &&
        await updateConfig(2)) {
      print("Server succesfull shutting down ...");
      exit(0);
    }
    else {
      print("Error at closing the server.");
      exit(1);
    }
  }
}