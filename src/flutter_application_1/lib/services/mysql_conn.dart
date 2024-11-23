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

  // Example: Fetch data from the database
  Future<List<Map<String, dynamic>>> fetchData(String query) async {
    final conn = await connect();
    final results = await conn.execute(query);
    return results.rows.map((row) => row.assoc()).toList();
    await conn.close();
  }

  // Example: Insert data into the database
  Future<void> insertData(String query, List<dynamic> values) async {
    final conn = await connect();
    await conn.execute(query, params: values);
    print('Data inserted successfully!');
    await conn.close();
  }
}
