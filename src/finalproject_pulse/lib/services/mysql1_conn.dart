import "dart:async";
import "package:mysql1/mysql1.dart";

// Since this a class "DataBaseConnSQL1", when implementing it, use:
// final DataBaseConnSQL1 _dbConn(any var name) = DataBaseConnSQL1();
// to construct this class for its methods

// NOTE: change the config according to your MySQL workbench since its local database, not
// online database currently (LINE 15 - 20)
// ALSO MAKE SURE WORKBENCH IS OPEN FOR connection

// Side note: all of these are async methods, must be in a async function to work
// But I will deal with it for the most part

class DataBaseConnSQL1 {
  var settings = new ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'abc123abcd',
      db: 'final_pos');

// Connect to database
// Remember to close connection with .close(); everytime you use connect() for operations
  Future<MySqlConnection> connect() async {
    var conn = await MySqlConnection.connect(settings);
    return conn;
  }

// Fetch all data method
// WIP: need to do a stateful widget for showing up in UI
// This will return and print plain text
  Future<List<Map<String, dynamic>>> fetchAllData(String tableName) async {
    final conn = await connect();

    try {
      // Query to select all data from the table
      var results = await conn.query('SELECT * FROM $tableName');

      // Parse results into a list of maps for better usability
      List<Map<String, dynamic>> allData = [];
      for (var row in results) {
        var data = <String, dynamic>{};
        for (var i = 0; i < row.fields.length; i++) {
          data[row.fields.keys.elementAt(i)] = row[i];
        }
        allData.add(data);
      }

      return allData;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    } finally {
      // Close the connection
      await conn.close();
    }
  }
}
