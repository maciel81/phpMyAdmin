<?php
//-- Blowfish Secret
$cfg['blowfish_secret'] = md5('Fundação DER-RJ');
//-- Default Language & Theme
$cfg['DefaultLang']  = 'pt_BR';
$cfg['ThemeDefault'] = 'metro';
//-- MySQL Hosts
$i=0;
$hosts = array (
    "db2.der.rj",
    "hmlg.der.rj",
    "db.der.rj",
    "legacy.der.rj",
);
foreach ($hosts as $host) {
    $i++;
    //-- Authtentication
    $cfg['Servers'][$i]['AllowNoPassword'] = false;
    //-- Server Parameters
    $cfg['Servers'][$i]['host']     = $host;
    $cfg['Servers'][$i]['compress'] = false;
}

