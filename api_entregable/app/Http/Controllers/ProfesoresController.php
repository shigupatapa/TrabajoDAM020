<?php

namespace App\Http\Controllers;

use App\Models\Profesor;
use Illuminate\Http\Request;

class ProfesoresController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Profesor::orderBy('nombreCompleto')->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $profesor = new Profesor();
        $profesor->rutProfesor = $request->rutProfesor;
        $profesor->nombreCompleto = $request->nombreCompleto;
        $profesor->fechaNacimiento = $request->fechaNacimiento;
        $profesor->nivel_id = $request->nivel_id;
        $profesor->save();
        return $profesor;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Profesor  $profesor
     * @return \Illuminate\Http\Response
     */
    public function show(Profesor $profesor)
    {
        return $profesor;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Profesor  $profesor
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Profesor $profesor)
    {
        //$profesor->rutProfesor = $request->rutProfesor;
        $profesor->nombreCompleto = $request->nombreCompleto;
        $profesor->fechaNacimiento = $request->fechaNacimiento;
        $profesor->nivel_id = $request->nivel_id;
        $profesor->save();
        return $profesor;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Profesor  $profesor
     * @return \Illuminate\Http\Response
     */
    public function destroy(Profesor $profesor)
    {
        $profesor->delete();
    }
}
