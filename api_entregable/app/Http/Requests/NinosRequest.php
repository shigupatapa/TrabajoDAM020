<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NinosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'rutNino' => 'required|unique:ninos,rutNino|max:12',
            'nombreCompleto' => 'required|max:60|min:3',
            'nivel_id' => 'required|exists:niveles,nivel_id',
            'sexo' => 'required',
            'fechaNacimiento'=> 'date|required',
            'nombreApoderado'=>'required|max:60|min:3',
            'telefono1'=>'required|max:12',
            'telefono2'=>'max:12',
            'alergias' => 'max:255',
            'imagen' => 'image'
        ];
    }
    public function messages()
{
    return [
        'rutNino.required' => 'El RUT es obligatorio.',
        'rutNino.unique' => 'El RUT :input ya existe.',
        'rutNino.max' => 'El RUT no debe tener más de 12 caracteres.',
        'nombreCompleto.required' => 'El nombre completo es obligatorio.',
        'nombreCompleto.max' => 'El nombre completo no debe tener más de 60 caracteres.',
        'nombreCompleto.min' => 'El nombre completo debe tener al menos 3 caracteres.',
        'nivel_id.required' => 'El campo nivel es obligatorio.',
        'nivel_id.exists' => 'El campo nivel es obligatorio.',
        'sexo.required' => 'El campo sexo es obligatorio', //no sean mal pensados XD
        'fechaNacimiento.date'=>'La fecha de nacimiento no es una fecha válida.',
        'fechaNacimiento.required'=>'La fecha de nacimiento es obligatoria.',
        'nombreApoderado.required' => 'El nombre de apoderado es obligatorio.',
        'nombreApoderado.max' => 'El nombre de apoderado no debe tener más de 60 caracteres.',
        'nombreApoderado.min' => 'El nombre de apoderado debe tener al menos 3 caracteres.',
        'telefono1.required' => 'El telefono 1 es obligatorio.',
        'telefono1.max' => 'El telefono no debe tener más de 12 caracteres.',
        'telefono2.max' => 'El telefono no debe tener más de 12 caracteres.',
        'alergias.max' => 'Las alegias no debe tener más de 255 caracteres.',
        'imagen.image' => 'El campo imagen debe ser una imagen.',
    ];
}
}
