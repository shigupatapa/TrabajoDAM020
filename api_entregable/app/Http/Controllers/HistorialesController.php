<?php

namespace App\Http\Controllers;

use App\Models\Historial;
use Illuminate\Http\Request;

class HistorialesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Historial::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $historial = new Historial();
        $historial->rutNino = $request->rutNino;
        $historial->titulo = $request->titulo;
        //$historial->fecha = $request->fecha;
        $historial->contenido = $request->contenido;
        $historial->save();
        return $historial;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function show(Historial $historial)
    {
        return $historial;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Historial $historial)
    {
        //$historial->rutNino = $request->rutNino;
        $historial->titulo = $request->titulo;
        //$historial->fecha = $request->fecha;
        $historial->contenido = $request->contenido;
        $historial->save();
        return $historial;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function destroy(Historial $historial)
    {
        //
    }
}
