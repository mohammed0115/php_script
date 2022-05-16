<?php
 require_once "phpseclib\Crypt\RSA";
   function publicEncRSA($pubKey, $data) {
        $keyDER = base64_decode($pubKey);
        $rsa = new RSA();
        $rsa->loadKey($keyDER);
        $rsa->setEncryptionMode(RSA::ENCRYPTION_PKCS1);
        $encryptedToken = base64_encode($rsa->encrypt($data));
        return $encryptedToken;
    }

?>