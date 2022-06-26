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
            'nivel_id' => 'required|numeric|exists:niveles,nivel_id',
            'sexo' => 'required|max:1',
            'fechaNacimiento'=> 'date|required',
            'nombreApoderado'=>'required|max:60|min:3',
            'telefono1'=>'max:12',
            'telefono2'=>'max:12',
            'alergias' => 'max:255',
            'imagen' => 'image'
            
        ];
    }
    public function messages()
{
    return [
        'rutNino.required' => 'El rut es obligatorio.',
        'rutNino.unique' => 'El rut :input ya existe.',
        'rutNino.max' => 'El rut no debe tener más de 12 caracteres.',
        'nombreCompleto.required' => 'El nombre completo es obligatorio.',
        'nombreCompleto.max' => 'El nombre completo no debe tener más de 60 caracteres.',
        'nombreCompleto.min' => 'El nombre completo debe tener al menos 3 caracteres.',
        'nivel_id.numeric' => 'El id debe ser un número.',
        'nivel_id.required' => 'El campo de identificación del nivel es obligatorio.',
        'nivel_id.exists' => 'El id :input seleccionado no es válido.',
        'sexo.required' => 'El sexo es obligatorio', //no sean mal pensados XD
        'sexo.max' => 'El sexo no debe tener más de 1 carácter.',
        'fechaNacimiento.date'=>'La fecha de nacimiento no es una fecha válida.',
        'fechaNacimiento.required'=>'La fecha de nacimiento es obligatoria.',
        'nombreApoderado.required' => 'El nombre de apoderado es obligatorio.',
        'nombreApoderado.max' => 'El nombre de apoderado no debe tener más de 60 caracteres.',
        'nombreApoderado.min' => 'El nombre de apoderado debe tener al menos 3 caracteres.',
        'telefono1.max' => 'El telefono no debe tener más de 12 caracteres.',
        'telefono2.max' => 'El telefono no debe tener más de 12 caracteres.',
        'alergias.max' => 'Las alegias no debe tener más de 255 caracteres.',
        'imagen.image' => 'El campo imagen debe ser una imagen.',


    ];
}
}
