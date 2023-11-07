<?php
return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
    ],

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],
    'facebook' => [
        'client_id' => '1056375581823890',
        'client_secret' => '0f4ab3ad93f8b5d53606b758bd53c8a7',
        'redirect' => 'http://localhost/website_quanlycoffee/public/callback/facebook'
    ],
    'google' => [
        'client_id' => '872153443222-flgmpsqdshqa8lmsgpl0l5gnqopbrepe.apps.googleusercontent.com',
        'client_secret' => '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',
        'redirect' => 'http://127.0.0.1:8000/callback/google'
    ],

];
// http://127.0.0.1:8000/callback/google
// http://localhost/website_quanlycoffee/public/callback/google