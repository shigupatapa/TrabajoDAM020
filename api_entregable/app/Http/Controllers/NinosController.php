<?php

namespace App\Http\Controllers;

use App\Models\Nino;
use Illuminate\Http\Request;

class NinosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Nino::orderBy('nombreCompleto')->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $nino = new Nino();
        $nino->rutNino = $request->rutNino;
        $nino->nombreCompleto = $request->nombreCompleto;
        $nino->nivel_id = $request->nivel_id;
        $nino->fechaNacimiento = $request->fechaNacimiento;
        $nino->nombreApoderado = $request->nombreApoderado;
        $nino->telefono1 = $request->telefono1;
        $nino->telefono2 = $request->telefono2;
        $nino->alergias = $request->alergias;
        $nino->save();
        return $nino;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function show(Nino $nino)
    {
        return $nino;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Nino $nino)
    {
        //$nino->rutNino = $request->rutNino;
        $nino->nombreCompleto = $request->nombreCompleto;
        $nino->nivel_id = $request->nivel_id;
        $nino->fechaNacimiento = $request->fechaNacimiento;
        $nino->nombreApoderado = $request->nombreApoderado;
        $nino->telefono1 = $request->telefono1;
        $nino->telefono2 = $request->telefono2;
        $nino->alergias = $request->alergias;
        $nino->save();
        return $nino;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function destroy(Nino $nino)
    {
        $nino->delete();
    }
}
