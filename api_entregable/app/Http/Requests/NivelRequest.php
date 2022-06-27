<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NivelRequest extends FormRequest
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
            'nombreNivel' => 'required|max:30'
        ];
    }
    public function messages()
    {
        return [
            'nombreNivel.required' => 'El nombre del nivel es obligatorio.',
            'nombreNivel.max' => 'El nombre del nivel no debe tener más de 30 caracteres.'
            
        ];
    }
}
