<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Profesor extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'profesores';
    Protected $primaryKey = 'rutProfesor';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;
    public function nivel(){
        return $this->belongsTo(Nivel::class);
    }
}
