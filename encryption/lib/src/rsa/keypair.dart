import 'dart:math';
import 'dart:typed_data';

import 'package:encryption/encryption.dart';
import 'package:pointycastle/export.dart' as pointy;

/// [Keypair] using RSA Algorithm
class RSAKeypair implements Keypair {
  late RSAPrivateKey _privateKey;
  late RSAPublicKey _publicKey;

  /// Bi tane [RSAPrivateKey] kullanarak [RSAKeypair] oluşturuyoruz
  RSAKeypair(this._privateKey) : _publicKey = _privateKey.publicKey;

  /// Varsayılan anahtar boyutu 2048 bit olan random bir [RSAKeypair] oluşturuyoruz
  ///
  /// Önerilen anahtar boyutu 4096'dır, ancak geriye dönüş uyumluluğunu sağlamak için 2048 olarak değiştirilmiştir
  RSAKeypair.fromRandom({int keySize = 2048}) {
    final keyParams =
        pointy.RSAKeyGeneratorParameters(BigInt.parse('65537'), keySize, 12);

    final fortunaRandom = pointy.FortunaRandom();
    final random = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    fortunaRandom.seed(pointy.KeyParameter(Uint8List.fromList(seeds)));

    final randomParams = pointy.ParametersWithRandom(keyParams, fortunaRandom);
    final generator = pointy.RSAKeyGenerator();
    generator.init(randomParams);

    final pair = generator.generateKeyPair();
    final publicKey = pair.publicKey as pointy.RSAPublicKey;
    final privateKey = pair.privateKey as pointy.RSAPrivateKey;

    _publicKey = RSAPublicKey(publicKey.modulus!, publicKey.exponent!);
    _privateKey = RSAPrivateKey(privateKey.modulus!, privateKey.exponent!,
        privateKey.p!, privateKey.q!);
  }

  @override
  RSAPublicKey get publicKey => _publicKey;

  @override
  RSAPrivateKey get privateKey => _privateKey;
}
