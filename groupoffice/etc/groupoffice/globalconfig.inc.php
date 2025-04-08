<?php

$config = [
        // GO will connect to this installation to add a mailbox. It is the full url to the Group-Office installation with the postfixadmin module installed.
//        'serverclient_server_url' => 'http://host.docker.internal:8111/',

        // A token to authenticate. The token has to be identical on the web and mail server. By default they are the same server so you can just set anything here.
//        'serverclient_token' => '677be6c58194956f1c2c49b1b05cb83f8ff2de570bd5a',

        // Comma separated list of mailbox domains
//        'serverclient_domains' => 'intermesh.nl',

//				'serverclient_jmap' => true,

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
        'serverclient_smtp_password' => '',
//'product_name' => 'My Office',
//'custom_css_url' => '/branding/style.css',
//'support_link' => 'https://www.intermesh.nl'
//'allowed_modules' => 'bookmarks,caldav,calendar,carddav,comments,cron,dav,demodata,documenttemplates,dropbox,email,exactonline,files,gota,hoursapproval2,leavedays,log,notes,pr2analyzer,projects2,reminders,savemailas,scanbox,search,settings,sieve,site,smime,summary,sync,syncml,tasks,tickets,timeregistration2,tools,webodf,zpushadmin,serverclient,users,groups,modules,bgsupdateprojectrate,links,googleauthenticator,imapauthenticator,ldapauthenticator,billing,assistant,business/*,community/*,calendartimetracking'

//'email_allow_body_search' => true,

'community' => [
	'email' => [
		'allFolder' => [
			'mailserver' => 'virtual/All'
			]
		]
	]

];
