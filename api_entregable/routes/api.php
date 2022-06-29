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

// NIVELES
Route::get('/niveles',[NivelesController::class,'index']);
Route::get('/niveles/{nivel}',[NivelesController::class,'show']);
Route::get('/niveles/{nivel}/niños',[NivelesController::class,'filterNinos']);
Route::get('/niveles/{nivel}/profes',[NivelesController::class,'filterProfes']);
Route::post('/niveles',[NivelesController::class,'store']);
Route::delete('niveles/{nivel}',[NivelesController::class,'destroy']);
Route::put('/niveles/{nivel}',[NivelesController::class,'update']);

// NIÑOS
Route::get('/niños',[NinosController::class,'index']);
Route::get('/niños/{nino}',[NinosController::class,'show']);
Route::get('/niños/imagen/{nino}',[NinosController::class,'image']);
Route::get('/niños/{nino}/historial',[NinosController::class,'historialbyNino']);
Route::post('/niños',[NinosController::class,'store']);
Route::delete('niños/{nino}',[NinosController::class,'destroy']);
Route::put('/niños/{nino}',[NinosController::class,'update']);
Route::put('/niños/rut/{nino}',[NinosController::class,'updateR']);

// PROFESORES
Route::get('/profesores',[ProfesoresController::class,'index']);
Route::get('/profesores/{profesor}',[ProfesoresController::class,'show']);
Route::post('/profesores',[ProfesoresController::class,'store']);
Route::delete('profesores/{profesor}',[ProfesoresController::class,'destroy']);
Route::put('/profesores/{profesor}',[ProfesoresController::class,'update']);
Route::put('/profesores/rut/{profesor}',[ProfesoresController::class,'updateR']);

// HISTORIAL
Route::get('/historiales',[HistorialesController::class,'index']);
Route::get('/historiales/{historial}',[HistorialesController::class,'show']);
Route::post('/historiales',[HistorialesController::class,'store']);
Route::delete('historiales/{historial}',[HistorialesController::class,'destroy']);
Route::put('/historiales/{historial}',[HistorialesController::class,'update']);