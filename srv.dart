import 'dart:io';
import 'package:mysql1/mysql1.dart';

var connectionSettings new ConnectionSettings(host: '127.0.0.1', port: 3306, user: 'root', password: 'root', db: 'observatory',)

void main() async {
	// запуск web-сервера.
  var server = await HttpServer.bind(InternetAddress.anyIPv6, 8888);
  print("Listening for connections on http://localhost:8888/");
  await server.forEach((HttpRequest request) {
 
    switch (request.uri.path) {
		case "/":
			print(request.uri);
			var uri = Uri.parse(request.uri.toString());
			uri.queryParameters.forEach((k, v) {
				print('key: $k - value: $v');
			});
			print('Count: '+uri.queryParameters.length.toString());
			if (uri.queryParameters.length > 0) {
				// добавление одной строки в таблицу.
				rowInsert(uri.queryParameters);
			}
			break;
    }
    final res = request.response;
	ReadTpl(res);

  });
}

void ReadTpl(res) async {
	res.headers.add(HttpHeaders.contentTypeHeader, "text/html; charset=utf-8");
	File file = File("select.html");
	var lines = await file.readAsLines();
	for(final line in lines){
	print(line);
		
		if ((line != "@tr") && (line != "@ver")) {
			res.write(line);
		}
		if (line.contains("@tr")) {
			String message = await viewSelect(res);
		}
		if (line.contains("@ver")) {
			String message = await viewVer(res);
		}		
	}
	 
	res.close();
	print("User is ok.");
}

Future<String> viewSelect(res) async {
	final conn = await MySqlConnection.connect(connectionSettings);
	res.write('<table>');
	var heads = await conn.query("SHOW COLUMNS FROM objects");
	res.write('<tr>');
	for (var head in heads) {
		res.write('<td>${head[0]}</td>');
		print('${head[0]}');
	}
	res.write('</tr>');	
	
	var rows = await conn.query("SelectAllFromObjects()");
	for (var row in rows) {
		res.write('<tr>');
		for (var col in row) {
			res.write('<td>${col}</td>');
		//	print('${col}');
		}
		res.write('</tr>');
	}
	res.write('</table>');
	await conn.close();
	return Future.delayed(Duration(seconds: 0), () => "Hello Dart");
}

Future<String> viewVer(res) async {
	final conn = await MySqlConnection.connect(connectionSettings);
	var vers = await conn.query("SELECT VERSION() AS ver");
	for (var ver in vers) {
		res.write('${ver[0]}');
		print('${ver[0]}');
	}
	await conn.close();
	return Future.delayed(Duration(seconds: 0), () => "Hello Dart");
}

Future<String> rowInsert(mass) async {

	String sValue = '';
	int i=0;
	mass.forEach((k, v) {
		print('key: $k - value: $v');
		if (i>0){sValue = sValue+',';}
		sValue = sValue+"'$v'";
		i++;
	});
	sValue = 'INSERT INTO objects (type, accuracy, amount, time, date, notes) VALUES ('+sValue+')';
	
	final conn = await MySqlConnection.connect(connectionSettings);
	await conn.query(sValue);
	await conn.close();
	print('Insert into table is good.');

	return Future.delayed(Duration(seconds: 0), () => "Hello Dart");
}
