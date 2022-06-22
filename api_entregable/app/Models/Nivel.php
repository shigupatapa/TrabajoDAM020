<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Nivel extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'niveles';
    protected $primaryKey = 'nivel_id';
    //public $incrementing = true;
    public $timestamps = false;
    public function ninos(){
        return $this->hasMany(Nino::class);
    }
    public function profesores(){
        return $this->hasMany(Profesor::class);
    }
}
