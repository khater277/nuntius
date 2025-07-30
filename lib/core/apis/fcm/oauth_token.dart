import 'package:googleapis_auth/auth_io.dart';

class FirebaseAccessToken {
  static String firebaseMsgScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  static Future<String> getToken() async {
    try {
      final credentials = ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "nuntius-b9cca",
        "private_key_id": "ba811f802f0bbc02ac019b8bbbe85bf33f1f80bd",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC+9S4cVwe1mWD1\nDXlEBc3Il8gKDuPq6hppbgEqL111WjZMBB1LwxyzUz9qUW1/yvOb/LsB+Ine1lDE\nxXMDkvYGqhaTWCOjpOySMIpPV15qdtCqplP/TfPGICV3T4ygNK8crrRw6n5c0Wnr\nGZraS3sM5GoYkbInouh+46tLIOtd94k24Wsn3Sa+pFJiaiW2pP7oTNqC8mOMBToA\nMv53eY8iYqvWn1T8FBkj5ywv4h4gxNCs5uimm/SjMhAlmbvrFEbaghEF5ezpDu0F\njrOO3w8OmDuWNEXzYKUtUl0ZvMHKbQBGVN1Gd4pQSuMRe12klKVY0xPXOFYeGIsf\nqDLb9NHrAgMBAAECggEAQkKIG/xU5/4PJyjkNaa/54VHO7o7+rT9siyiCdXCm6hQ\nY+MfmTzcFhtiS01y7d9p1WwGJeJsUJ7UCtsqlAhoBxr412rDfxKIphdivrIlyFJv\nCG/LgLC3UD2yUmqPdL2jL5Qtd2requ1dT98kHPAJBAm0CM9xXpCIFROBygFjukhD\nRDNCUlIJuNp5L58dgI1+XcmDwVNQYXOpr+TTDACBsdnEeS56R4rzxfOLr1BS1CVk\nJg3+n3qFxs1aH0Y4kTvBfblGlA5zSP5iceDkQuTsx5PHMO7ZsOhIefkpy+xvL5HS\nihVh+R7LQ+Kh4hyHnbY2JViXyNRGaz10SA3llOZvWQKBgQDnMcpCwZzW8H5mlb8S\nGguDJYtF+8/jz9d4AUOJX8ymYoMDHM5DEGbKOKynpmn8tk1Wa5IK8sov5uwAjmSN\nS8ST5vUDP8YaU+rpVmEM19elRRndodQHaE2aSFSgjizgitZyyHJRcCOmIEzmAXsJ\nhOk/fqmAju9qI0/rjb2A8qHMGQKBgQDTcjVoBR4vLrIH5aJHC4wgnJbRe631pID7\niDKDVzqPNwoxE54uX6MpaP5CvSEtKGINIypiUMICxYaeGleGVdGuPYgtCam9R0sj\n7aRhyEpHz+SQkkLd2aKAzsjF1lNl46SORQHv3vE4muTewTSsVZg6YBKb0P6gHwL2\n/VbGtMqOowKBgQCnXUjxiJ2Uj+bBNrhqT0Z0OzKWiBNX9Lcj3a5ZfWt2K6xyDWFX\n9UCkNeDvQK5LTmGwJRFFMbuib8X7JRmvm+EDvNcz8e/kUUmmf2ykUoB+2QY/ho4q\nipxbCu+Qhzv/lSJnV6pCQC7ebVWd0AaUvo3n9DaapV619Dg/6oz8EymDyQKBgQCj\nCn+P09Jwg0sXt8OnkIneY6APq5R5wv0J9v0sNUicQc6EBSKFk40WUzUrdPZuAaOJ\nicIWyTqwNGsW4iz3Epl6B0xHnhnaL20LKSUFmRFdyjnuGDmjIzugotJBaoAoIp4y\nbZeOxJOwGA++i6/36pBVAtuWdlLAWOlKVhJhaep+jQKBgBrlcmsiGTH7+R15ljcb\nv/5/DaNadRb4mVDXv4UEGBATkZWj0euU8x7L/WdLHYXRvoGRCSUDULK4Nect/UNv\noYMirpmGZ+eUT8R0VipsjGzLQH9nrJ/rheEb3ls2n9yRcrz7JRM+I3tAxvy6iLr8\nxC/Y5eQMr0NvZYTmgdkMixy/\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-a141q@nuntius-b9cca.iam.gserviceaccount.com",
        "client_id": "112466282277008771960",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-a141q%40nuntius-b9cca.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      });

      final client = await clientViaServiceAccount(
        credentials,
        [firebaseMsgScope],
      ).catchError((error) {
        print('Authentication error: $error');
        throw error;
      });

      if (client.credentials.accessToken.data.isEmpty) {
        throw Exception('Access token is empty');
      }

      return client.credentials.accessToken.data;
    } catch (e) {
      print('Detailed error: $e');
      return "ERROR======>${e.toString()}";
    }
  }
}
