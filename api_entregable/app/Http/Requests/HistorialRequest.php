<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class HistorialRequest extends FormRequest
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
            'rutNino' =>'required|exists:ninos,rutNino|max:12' ,
            'titulo' => 'required|max:60',
            'contenido' =>'required|max:255',
        ];
    }
    public function messages()
    {
        return [
            'rutNino.required' => 'El rut es obligatorio.',
            'rutNino.exists' => 'El rut :input no existe.',
            'rutNino.max' => 'El rut no debe tener más de 12 caracteres.',
            'titulo.required'=>'El titulo es obligatorio.',
            'titulo.max'=>'El titulo no debe tener más de 60 caracteres.',
            'contenido.required'=>'El contenido es obligatorio.',
            'contenido.max'=>'El titulo no debe tener más de 255 caracteres.',
        ];
    }
}
