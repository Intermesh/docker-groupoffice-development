<?php

$config = [
        // GO will connect to this installation to add a mailbox. It is the full url to the Group-Office installation with the postfixadmin module installed.
        'serverclient_server_url' => 'http://groupoffice-63/',
        // A token to authenticate. The token has to be identical on the web and mail server. By default they are the same server so you can just set anything here.

        'serverclient_token' => 'someSecureTokenOfyourChoice',

        // Comma separated list of mailbox domains
        'serverclient_domains' => 'intermesh.localhost',

        // The email account properties that will be added for the user
        'serverclient_mbroot' => '',
        'serverclient_use_ssl' => false,
        'serverclient_use_tls' => false,
        'serverclient_novalidate_cert' => '0',
        'serverclient_host' => 'mailserver',
        'serverclient_port' => 143,
        'serverclient_smtp_host' => 'mailserver',
        'serverclient_smtp_port' => 25,
        'serverclient_smtp_encryption' =>'',
        'serverclient_smtp_username' => '',
        'serverclient_smtp_password' => ''
];