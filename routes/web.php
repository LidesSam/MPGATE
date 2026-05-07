<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('landing');
});


Route::get('/amount-payment', function () {
    return view('amount-payment');
})->name("amount-payment");
