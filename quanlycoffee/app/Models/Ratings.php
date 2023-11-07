<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ratings extends Model
{
    use HasFactory;
    protected $table = 'ratings';
    protected $fillable = ['r_user_id', 'r_product_id', 'r_number', 'r_status', 'r_content'];


    public function customer()
    {
        return $this->hasOne(Customer::class, 'id', 'r_user_id');
    }

    public function products()
    {
        return $this->belongsTo(Products::class,'r_product_id');
    }
}
