<?php

namespace App\Http\Controllers;

use App\Models\Nino;
use App\Models\Historial;
use App\Http\Requests\{NinosRequest,NinosRequestEdit,NinosRequestEditRut};


class NinosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function image(Nino $nino){
        if ($nino->imagen==null){
            $file = public_path('imagen/default.jpg');
            return response()->download($file);
        }else {
            $fileName = $nino->imagen;
            $file = public_path('imagen/'.$fileName);
            return response()->download($file);
        }
    }
    public function index()
    {
        return Nino::orderBy('nombreCompleto')->get();
    }

    public function historialbyNino(Nino $nino)
    {
        return Historial::where('rutNino', $nino->rutNino)->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(NinosRequest $request)
    {
        $nino = new Nino();
        $nino->rutNino = $request->rutNino;
        $nino->nombreCompleto = $request->nombreCompleto;
        $nino->nivel_id = $request->nivel_id;
        $nino->sexo = $request->sexo;
        $nino->fechaNacimiento = $request->fechaNacimiento;
        $nino->nombreApoderado = $request->nombreApoderado;
        $nino->telefono1 = $request->telefono1;
        $nino->telefono2 = $request->telefono2;
        $nino->alergias = $request->alergias;
        if (file_exists($request->imagen)){
            $imagen = $request->file('imagen');
            $ruta = 'imagen/';
            $nombreArchivo = date('YmdHis'). "." . $imagen->getClientOriginalExtension();
            $imagen->move($ruta,$nombreArchivo);
        }else{
            $nombreArchivo = null;
        }
        $nino->imagen = $nombreArchivo;
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
    public function updateR(NinosRequestEditRut $request, Nino $nino)
    {
        $nino->rutNino = $request->rutNino;
        $nino->nombreCompleto = $request->nombreCompleto;
        $nino->nivel_id = $request->nivel_id;
        $nino->sexo = $request->sexo;
        $nino->fechaNacimiento = $request->fechaNacimiento;
        $nino->nombreApoderado = $request->nombreApoderado;
        $nino->telefono1 = $request->telefono1;
        $nino->telefono2 = $request->telefono2;
        $nino->alergias = $request->alergias;
        if (file_exists($request->imagen)){ 
            //public_path('imagen/'.$nino->imagen)->delete();
            $imagen = $request->file('imagen');
            $ruta = 'imagen/';
            $nombreArchivo = date('YmdHis'). "." . $imagen->getClientOriginalExtension();
            $imagen->move($ruta,$nombreArchivo);
        }else{
            $nombreArchivo = $nino->imagen;
        }
        $nino->imagen = $nombreArchivo;
        $nino->save();
        return $nino;
        
    }
    public function update(NinosRequestEdit $request, Nino $nino)
    {
        $nino->nombreCompleto = $request->nombreCompleto;
        $nino->nivel_id = $request->nivel_id;
        $nino->sexo = $request->sexo;
        $nino->fechaNacimiento = $request->fechaNacimiento;
        $nino->nombreApoderado = $request->nombreApoderado;
        $nino->telefono1 = $request->telefono1;
        $nino->telefono2 = $request->telefono2;
        $nino->alergias = $request->alergias;
        if (file_exists($request->imagen)){ 
            //public_path('imagen/'.$nino->imagen)->delete();
            $imagen = $request->file('imagen');
            $ruta = 'imagen/';
            $nombreArchivo = date('YmdHis'). "." . $imagen->getClientOriginalExtension();
            $imagen->move($ruta,$nombreArchivo);
        }else{
            $nombreArchivo = $nino->imagen;
        }
        $nino->imagen = $nombreArchivo;
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
