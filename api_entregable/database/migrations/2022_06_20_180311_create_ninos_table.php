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
            $table->string('rutNino',12)->primary();
            $table->string('nombreCompleto',60);
            $table->string('sexo',1);
            $table->unsignedBigInteger('nivel_id');
            $table->date('fechaNacimiento');
            $table->string('nombreApoderado',60);
            $table->string('telefono1',12);
            $table->string('telefono2',12)->nullable();
            $table->string('alergias')->nullable();
            $table->string('imagen')->nullable();
            $table->softDeletes();
            $table->foreign('nivel_id')->references('nivel_id')->on('niveles');
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
