-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-07-2022 a las 03:44:36
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: `jardininfantil`
--
CREATE DATABASE IF NOT EXISTS `jardininfantil` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;
USE `jardininfantil`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `nHistorial` int(10) UNSIGNED NOT NULL,
  `rutNino` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial`
--

INSERT INTO `historial` (`nHistorial`, `rutNino`, `titulo`, `contenido`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '20.456.372-1', 'Mal Comportamiento', 'En reiteradas ocasiones se ha visto involucrado en peleas con distintos niños del jardin.', '2022-06-28 14:20:45', '2022-06-30 04:19:06', NULL),
(2, '21.390.450-2', 'Retirada por Vómitos', 'Debido a malestares estomacales fue retirada por su tutor de manera anticipada.', '2022-06-28 22:55:20', '2022-06-30 04:19:06', NULL),
(3, '20.456.372-1', 'Descenso de Nivel', 'El niño es descendido de un nivel debido a su mal comportamiento', '2022-06-30 12:35:05', '2022-06-30 12:35:05', NULL),
(4, '20.007.007-K', 'Reconocimiento Estelar', 'Por sus buenas acciones y contribuciones a la sociedad, hacemos entrega de una estrellita dorada.', '2022-06-30 17:15:55', '2022-06-30 04:19:06', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(32, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(33, '2022_06_20_174834_create_niveles_table', 1),
(34, '2022_06_20_180311_create_ninos_table', 1),
(35, '2022_06_20_180411_create_profesores_table', 1),
(36, '2022_06_20_180507_create_historial_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ninos`
--

CREATE TABLE `ninos` (
  `rutNino` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCompleto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel_id` bigint(20) UNSIGNED NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `nombreApoderado` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono1` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono2` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alergias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ninos`
--

INSERT INTO `ninos` (`rutNino`, `nombreCompleto`, `sexo`, `nivel_id`, `fechaNacimiento`, `nombreApoderado`, `telefono1`, `telefono2`, `alergias`, `imagen`, `deleted_at`) VALUES
('20.000.000-0', 'Nezuko Yajaira Kamado Pozo', 'F', 6, '2020-04-08', 'Tanjiro Kamado', '910203040', NULL, NULL, 'Nezuko.jpg', NULL),
('20.007.007-K', 'Anya Yolanda Forger Briar', 'F', 5, '2021-05-05', 'Loid Forger', '911223344', NULL, 'Mani', 'Anya.png', NULL),
('20.123.456-K', 'Ushio Okazaki Furukawa', 'F', 1, '2022-01-05', 'Nagisa Furukawa', '912345678', NULL, NULL, 'Ushio.jpg', NULL),
('20.456.372-1', 'Conan Edogawa Kudo', 'M', 5, '2018-03-04', 'Shinichi Kudo', '918452745', NULL, 'Penicilina', 'Conan.png', NULL),
('21.390.450-2', 'Usagi Yajaira Tsukino Chibiusa', 'F', 2, '2022-05-31', 'Usagi Tsukino', '999999999', NULL, NULL, NULL, NULL),
('22.979.377-4', 'Misuzu Kamio Tachibana', 'F', 2, '2021-04-24', 'Haruko Kamio', '991986612', '999070531', '', 'Misuzu.png', NULL),
('22.999.111-0', 'Kataro Josefino Sato Huerta', 'M', 4, '2020-01-08', 'Shin Karino Tamaru', '988112277', NULL, NULL, 'Kataro.jpg', NULL),
('24.500.003-9', 'Hitori Yenifer Bocchi Komi', 'F', 2, '2018-10-05', 'Shouko Komi Tadano', '938475619', NULL, 'Yodo', 'Bocchi.jpg', NULL),
('25.777.000-7', 'Shouta Bryan Magatsuchi Nuñez', 'M', 3, '2020-10-08', 'Lucoa Magatsuchi Kobayashi', '988776655', NULL, 'Lactosa', 'Shouta.jpg', NULL),
('27.722.772-7', 'Lilian Hoshikawa Futanari', 'M', 4, '2020-07-15', 'Takeo Go Franchouchou', '955555555', NULL, NULL, 'Lily.png', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles`
--

CREATE TABLE `niveles` (
  `nivel_id` bigint(20) UNSIGNED NOT NULL,
  `nombreNivel` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalles` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `niveles`
--

INSERT INTO `niveles` (`nivel_id`, `nombreNivel`, `detalles`, `deleted_at`) VALUES
(1, 'Sala Cuna Menor', '85 días - 1 año', NULL),
(2, 'Sala Cuna Mayor', '1 año - 2 años', NULL),
(3, 'Nivel Medio Menor', '2 años - 3 años', NULL),
(4, 'Nivel Medio Mayor', '3 años - 4 años', NULL),
(5, 'Primer Nivel Transición', '4 años', NULL),
(6, 'Segundo Nivel Transición', '5 años', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `rutProfesor` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCompleto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `nivel_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`rutProfesor`, `nombreCompleto`, `sexo`, `fechaNacimiento`, `nivel_id`, `deleted_at`) VALUES
('10011001-K', 'Paola Badilla Ballesteros', 'F', '1992-04-08', 2, NULL),
('11011001-K', 'Mireya Maldonado Pavéz', 'F', '1970-04-08', 5, NULL),
('11223344-0', 'Karla Donoso Contreras', 'F', '1993-06-01', 3, NULL),
('11277772-5', 'Paola Marlen Valdivia Bustamante', 'F', '1992-04-08', 1, NULL),
('12121212-4', 'Maria Jesús Castro Soto', 'F', '1988-02-10', 6, NULL),
('13001300-9', 'Tamara Georgia Bonvallet Nievas', 'F', '2020-05-31', 1, NULL),
('13131313-5', 'Ana Gabriel Perales Laferte', 'F', '1975-10-10', 5, NULL),
('15221522-8', 'Monserrat Araya Peréz', 'F', '1995-03-04', 1, NULL),
('17171717-K', 'Angela Belén Nuñez Martinez', 'F', '1996-03-15', 3, NULL),
('18999000-1', 'Danitza Aros Contreras', 'F', '1990-01-05', 4, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`nHistorial`),
  ADD KEY `historial_rutnino_foreign` (`rutNino`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ninos`
--
ALTER TABLE `ninos`
  ADD PRIMARY KEY (`rutNino`),
  ADD KEY `ninos_nivel_id_foreign` (`nivel_id`);

--
-- Indices de la tabla `niveles`
--
ALTER TABLE `niveles`
  ADD PRIMARY KEY (`nivel_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`rutProfesor`),
  ADD KEY `profesores_nivel_id_foreign` (`nivel_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `nHistorial` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `niveles`
--
ALTER TABLE `niveles`
  MODIFY `nivel_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_rutnino_foreign` FOREIGN KEY (`rutNino`) REFERENCES `ninos` (`rutNino`);

--
-- Filtros para la tabla `ninos`
--
ALTER TABLE `ninos`
  ADD CONSTRAINT `ninos_nivel_id_foreign` FOREIGN KEY (`nivel_id`) REFERENCES `niveles` (`nivel_id`);

--
-- Filtros para la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD CONSTRAINT `profesores_nivel_id_foreign` FOREIGN KEY (`nivel_id`) REFERENCES `niveles` (`nivel_id`);
COMMIT;
