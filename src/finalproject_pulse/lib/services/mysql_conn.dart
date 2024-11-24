import 'package:mysql_client/mysql_client.dart/';

// Since this a class "DatabaseConn", when implementing it, use:
// final DatabaseConn _dbConn(any var name) = DatabaseConn();
// to construct this class for its methods

// NOTE: change the config according to your MySQL workbench since its local database, not
// online database currently (LINE 11 - 15)

// Side note: all of these are async methods, must be in a async function to work
// But I will deal with it for the most part

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
      databaseName: database,
    );

    await conn.connect();
    return conn;
  }

  // Example: Fetch data from the database
  // Used in opening up INVENTORY, STAFF, and anything that has a list
  Future<List<Map<String, dynamic>>> fetchData(String query) async {
    final conn = await connect();
    final results = await conn.execute(query);
    return results.rows.map((row) => row.assoc()).toList();
  }

  // Example: Insert data into the database
  // When adding stocks and when checking out(?)
  //new staff member directly query database
  Future<void> insertData(String query, List<dynamic> values) async {
    final conn = await connect();
    await conn.execute(query, bindParams: values);
    await conn.close();
  }
}
