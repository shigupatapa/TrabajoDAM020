<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('profesores', function (Blueprint $table) {
            $table->string('rutProfesor')->primary();
            $table->string('nombreCompleto');
            $table->date('fechaNacimiento');
            $table->unsignedBigInteger('nivel_id');
            $table->softDeletes();
            $table->foreign('nivel_id')->references('nivel_id')->on('niveles');

            //$table->unsignedBigInteger('categoria_id');
            //$table->foreign('categoria_id')->references('id')->on('categorias');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('profesores');
    }
};
