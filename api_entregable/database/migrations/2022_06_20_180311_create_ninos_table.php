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
        Schema::create('ninos', function (Blueprint $table) {
            $table->string('rutNino')->primary();
            $table->string('nombreCompleto');
            $table->unsignedBigInteger('nivel_id');
            $table->date('fechaNacimiento');
            $table->string('nombreApoderado');
            $table->string('telefono1');
            $table->string('telefono2');
            $table->string('alergias')->nullable;
            //$table->mediumblob('imagen');
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
        Schema::dropIfExists('ninos');
    }
};
