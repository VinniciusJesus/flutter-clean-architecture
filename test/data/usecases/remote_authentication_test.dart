import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  RemoteAuthentication({@required this.httpClient, this.url});

  final HttpClient httpClient;
  final String url;

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method}) {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct URL', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
