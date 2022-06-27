<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProfesoresRequest extends FormRequest
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
            'rutProfesor'=>'required|unique:profesores,rutProfesor|max:12',
            'nombreCompleto' =>'required|max:60|min:3',
            'fechaNacimiento' =>'date|required',
            'nivel_id' =>'required|numeric|exists:niveles,nivel_id'
        ];
    }
    public function messages()
    {
        return [
            'rutProfesor.required' => 'El rut es obligatorio.',
            'rutProfesor.unique' => 'El rut :input ya existe.',
            'rutProfesor.max' => 'El rut no debe tener más de 12 caracteres.',
            'nombreCompleto.required' => 'El nombre completo es obligatorio.',
            'nombreCompleto.max' => 'El nombre completo no debe tener más de 60 caracteres.',
            'nombreCompleto.min' => 'El nombre completo debe tener al menos 3 caracteres.',
            'fechaNacimiento.date'=>'La fecha de nacimiento no es una fecha válida.',
            'fechaNacimiento.required'=>'La fecha de nacimiento es obligatoria.',
            'nivel_id.numeric' => 'El id debe ser un número.',
            'nivel_id.required' => 'El campo de identificación del nivel es obligatorio.',
            'nivel_id.exists' => 'El id :input seleccionado no es válido.',
        ];
    }
}
