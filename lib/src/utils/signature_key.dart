import 'dart:math';

class SignatureKey {
  BigInt _p = BigInt.parse(
      '11519321960057750654331295158379994524690748001772963568222336839227172235423');
  BigInt _g = BigInt.parse('35916487252541714567687225850122353847');

  BigInt? clientSecretKey;
  BigInt? clientPublicKey;
  BigInt? serverPublicKey;
  BigInt? signatureSecret;

  SignatureKey();

  factory SignatureKey.fromJson(Map<String, dynamic> json) {
    final key = SignatureKey();
    key.clientSecretKey = json['client_secret_key'] == null
        ? null
        : BigInt.parse(json['client_secret_key']);
    key.clientPublicKey = json['client_public_key'] == null
        ? null
        : BigInt.parse(json['client_public_key']);
    key.serverPublicKey = json['server_public_key'] == null
        ? null
        : BigInt.parse(json['server_public_key']);
    key.signatureSecret = json['signature_secret'] == null
        ? null
        : BigInt.parse(json['signature_secret']);
    return key;
  }

  void resetClientKey() {
    final stringBuffer = StringBuffer('');
    {
      final random = Random();
      for (int i = 0; i < 40; i++) {
        final ran = random.nextInt(10);
        if (i == 0 && ran == 0) {
          i--;
          continue;
        }
        stringBuffer.write(ran);
      }
    }
    final res = stringBuffer.toString();
    clientSecretKey = BigInt.parse(res); // 客户端私钥
    clientPublicKey = _g.modPow(clientSecretKey!, _p); // 客户端公钥
  }

  void resetServerKey(BigInt serverPublicKey) {
    this.serverPublicKey = serverPublicKey;
    signatureSecret = serverPublicKey.modPow(clientSecretKey!, _p);
  }

  bool get isReadyToSign => signatureSecret != null;

  Map<String, dynamic> toJson() {
    final map = Map<String, dynamic>();
    map['client_secret_key'] = clientSecretKey?.toString();
    map['client_public_key'] = clientPublicKey?.toString();
    map['server_public_key'] = serverPublicKey?.toString();
    map['signature_secret'] = signatureSecret?.toString();
    return map;
  }
}