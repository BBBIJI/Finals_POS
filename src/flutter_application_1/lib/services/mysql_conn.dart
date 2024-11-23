import 'package:mysql_client/mysql_client.dart/';

class DatabaseConn {
  final String host = 'localhost';
  final int port = 3306;
  final String user = 'root';
  final String password = 'abc123abcd';
  final String database = 'final_pos';

  Future<MySQLConnection> connect() async {
    final conn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: database, // optional
    );
    await conn.connect();
    return conn;
  }
}
