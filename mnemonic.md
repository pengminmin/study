```bash
composer require bitwasp/bitcoin
composer require web3p/ethereum-util
```

```php
<?php
require_once './vendor/autoload.php';

use BitWasp\Bitcoin\Address\PayToPubKeyHashAddress;
use BitWasp\Bitcoin\Bitcoin;
use BitWasp\Bitcoin\Crypto\Random\Random;
use BitWasp\Bitcoin\Key\Factory\HierarchicalKeyFactory;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39Mnemonic;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39SeedGenerator;
use BitWasp\Bitcoin\Mnemonic\MnemonicFactory;

// Bip39
$math = Bitcoin::getMath();
$network = Bitcoin::getNetwork();
$random = new Random();
// 生成随机数(initial entropy)
$entropy = $random->bytes(Bip39Mnemonic::MIN_ENTROPY_BYTE_LEN);
$bip39 = MnemonicFactory::bip39();
// 通过随机数生成助记词
$mnemonic = $bip39->entropyToMnemonic($entropy);
echo "mnemonic: " . $mnemonic.PHP_EOL.PHP_EOL;// 助记词

$seedGenerator = new Bip39SeedGenerator();
// 通过助记词生成种子，传入可选加密串'hello'
$seed = $seedGenerator->getSeed($mnemonic);
echo "seed: " . $seed->getHex() . PHP_EOL;
$hdFactory = new HierarchicalKeyFactory();
$master = $hdFactory->fromEntropy($seed);

$hardened = $master->derivePath("49'/0'/0'/0/0");
echo 'WIF: ' . $hardened->getPrivateKey()->toWif();
echo PHP_EOL;
$address = new PayToPubKeyHashAddress($hardened->getPublicKey()->getPubKeyHash());
echo 'address: ' . $address->getAddress();
echo PHP_EOL;
```

```php
<?php
require_once './vendor/autoload.php';

use BitWasp\Bitcoin\Bitcoin;
use BitWasp\Bitcoin\Crypto\Random\Random;
use BitWasp\Bitcoin\Key\Factory\HierarchicalKeyFactory;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39Mnemonic;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39SeedGenerator;
use BitWasp\Bitcoin\Mnemonic\MnemonicFactory;
use Web3p\EthereumUtil\Util;

// Bip39
$math = Bitcoin::getMath();
$network = Bitcoin::getNetwork();
$random = new Random();
// 生成随机数(initial entropy)
$entropy = $random->bytes(Bip39Mnemonic::MIN_ENTROPY_BYTE_LEN);
$bip39 = MnemonicFactory::bip39();
// 通过随机数生成助记词
$mnemonic = $bip39->entropyToMnemonic($entropy);
echo "mnemonic: " . $mnemonic.PHP_EOL.PHP_EOL;// 助记词

$seedGenerator = new Bip39SeedGenerator();
// 通过助记词生成种子，传入可选加密串'hello'
$seed = $seedGenerator->getSeed($mnemonic);
echo "seed: " . $seed->getHex() . PHP_EOL;
$hdFactory = new HierarchicalKeyFactory();
$master = $hdFactory->fromEntropy($seed);

$util = new Util();
// 设置路径account
$hardened = $master->derivePath("44'/60'/0'/0/0");
echo " - m/44'/60'/0'/0/0 " .PHP_EOL;
echo " public key: " . $hardened->getPublicKey()->getHex().PHP_EOL;
echo " private key: " . $hardened->getPrivateKey()->getHex().PHP_EOL;// 可以导入到imtoken使用的私钥
echo " address: " . $util->publicKeyToAddress($util->privateKeyToPublicKey($hardened->getPrivateKey()->getHex())) . PHP_EOL;// 私钥导入imtoken后一样的地址
```

```php
<?php
require_once './vendor/autoload.php';

use BitWasp\Bitcoin\Address\PayToPubKeyHashAddress;
use BitWasp\Bitcoin\Bitcoin;
use BitWasp\Bitcoin\Crypto\Random\Random;
use BitWasp\Bitcoin\Key\Factory\HierarchicalKeyFactory;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39Mnemonic;
use BitWasp\Bitcoin\Mnemonic\Bip39\Bip39SeedGenerator;
use BitWasp\Bitcoin\Mnemonic\MnemonicFactory;
use BitWasp\Bitcoin\Network\NetworkFactory;

// Bip39
$math = Bitcoin::getMath();// 设置莱特币网络
$network = NetworkFactory::litecoin();
$random = new Random();
// 生成随机数(initial entropy)
$entropy = $random->bytes(Bip39Mnemonic::MIN_ENTROPY_BYTE_LEN);
$bip39 = MnemonicFactory::bip39();
// 通过随机数生成助记词
$mnemonic = $bip39->entropyToMnemonic($entropy);
//$mnemonic = 'security hurdle lift acoustic skate recall hotel elegant amateur hidden escape slow';
echo "mnemonic: " . $mnemonic.PHP_EOL.PHP_EOL;// 助记词

$seedGenerator = new Bip39SeedGenerator();
// 通过助记词生成种子，传入可选加密串'hello'
$seed = $seedGenerator->getSeed($mnemonic);
echo "seed: " . $seed->getHex() . PHP_EOL;
$hdFactory = new HierarchicalKeyFactory();
$master = $hdFactory->fromEntropy($seed);

$hardened = $master->derivePath("44'/2'/0'/0/0");
echo 'WIF ' . $hardened->getPrivateKey()->toWif($network);
echo PHP_EOL;
$address = new PayToPubKeyHashAddress($hardened->getPublicKey()->getPubKeyHash());
echo 'address ' . $address->getAddress($network);
echo PHP_EOL;
```

