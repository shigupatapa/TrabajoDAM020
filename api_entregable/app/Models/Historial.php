<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Historial extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'historial';
    Protected $primaryKey = 'nHistorial';
    public $timestamps = false;

}
