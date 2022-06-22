<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{NivelesController,NinosController,ProfesoresController,HistorialesController};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
//niveles
Route::get('/niveles',[NivelesController::class,'index']);
Route::get('/niveles/{nivel}',[NivelesController::class,'show']);
Route::post('/niveles',[NivelesController::class,'store']);
Route::delete('niveles/{nivel}',[NivelesController::class,'destroy']);
Route::patch('/niveles/{nivel}',[NivelesController::class,'update']);
//niños
Route::get('/niños',[NinosController::class,'index']);
Route::get('/niños/{nino}',[NinosController::class,'show']);
Route::post('/niños',[NinosController::class,'store']);
Route::delete('niños/{nino}',[NinosController::class,'destroy']);
Route::patch('/niños/{nino}',[NinosController::class,'update']);
//profesores
Route::get('/profesores',[ProfesoresController::class,'index']);
Route::get('/profesores/{profesor}',[ProfesoresController::class,'show']);
Route::post('/profesores',[ProfesoresController::class,'store']);
Route::delete('profesores/{profesor}',[ProfesoresController::class,'destroy']);
Route::patch('/profesores/{profesor}',[ProfesoresController::class,'update']);
//historial
Route::get('/historiales',[HistorialesController::class,'index']);
Route::get('/historiales/{historial}',[HistorialesController::class,'show']);
Route::post('/historiales',[HistorialesController::class,'store']);
Route::delete('historiales/{historial}',[HistorialesController::class,'destroy']);
Route::patch('/historiales/{historial}',[HistorialesController::class,'update']);