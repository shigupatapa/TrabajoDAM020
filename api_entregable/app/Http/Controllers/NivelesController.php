<?php

namespace App\Http\Controllers;

use App\Models\Nivel;
use App\Models\Nino;
use App\Models\Profesor;
use Illuminate\Http\Request;
use App\Http\Requests\NivelRequest;

class NivelesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Nivel::all();
    }

    public function filterNinos(Nivel $nivel)
    {
        return Nino::where('nivel_id', $nivel->nivel_id)->get();
    }

    public function filterProfes(Nivel $nivel)
    {
        return Profesor::where('nivel_id', $nivel->nivel_id)->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(NivelRequest $request)
    {
        $nivel = new Nivel();
        $nivel->nombreNivel = $request->nombreNivel;
        $nivel->detalles = $request->detalles;
        $nivel->save();
        return $nivel;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function show(Nivel $nivel)
    {
        return $nivel;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function update(NivelRequest $request, Nivel $nivel)
    {
        $nivel->nombreNivel = $request->nombreNivel;
        $nivel->detalles = $request->detalles;
        $nivel->save();
        return $nivel;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function destroy(Nivel $nivel)
    {
        $nivel->delete();
    }
}
