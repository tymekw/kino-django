-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 03 Lut 2021, 10:07
-- Wersja serwera: 8.0.21
-- Wersja PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `g08`
--

DELIMITER $$
--
-- Funkcje
--
CREATE DEFINER=`g08`@`localhost` FUNCTION `del_showtimes_finished` () RETURNS INT BEGIN
DECLARE do_zwrotu INT DEFAULT 1;
CREATE TEMPORARY TABLE showtime_finished (showtime_id INT);
INSERT INTO showtime_finished (showtime_id) SELECT m.showtime_ID FROM movie_showtime m WHERE m.date < (NOW() - INTERVAL 1 DAY);
delete m from movie_showtime m where m.showtime_ID in (select showtime_ID from showtime_finished); 
delete s from seat s where s.showtime_ID in (select showtime_ID from showtime_finished); 
delete t from ticket t where t.showtime_ID in (select showtime_ID from showtime_finished);

RETURN do_zwrotu;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$216000$a0vvj7p2jpuI$oBUvHr2j1BfBesyh4HcCMjrUeNcZ1IGfyTy6AnEmNpc=', '2021-02-03 08:57:54.916130', 1, 'admin', '', '', 'tymwid22@gmail.com', 1, 1, '2020-12-29 17:49:52.350831');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

--
-- Zrzut danych tabeli `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2020-12-30 14:03:15.632591', '1', '1', 1, '[{\"added\": {}}]', 8, 1),
(2, '2020-12-30 14:27:26.150550', '3', '3 Ojciec chrzestny 2020-12-15 00:00:00+00:00', 1, '[{\"added\": {}}]', 8, 1),
(3, '2020-12-30 14:27:26.509747', '2', '2 Skazani na Shawshank 2020-12-30 19:26:59+00:00', 1, '[{\"added\": {}}]', 8, 1),
(4, '2020-12-30 14:27:52.086621', '4', '4 Titanic 2020-12-31 06:00:00+00:00', 1, '[{\"added\": {}}]', 8, 1),
(5, '2020-12-30 14:28:10.489050', '5', '5 Forrest Gump 2020-12-30 14:27:52+00:00', 1, '[{\"added\": {}}]', 8, 1),
(6, '2021-01-02 15:59:45.290326', '9', '9 Forrest Gump 2020-12-30 14:27:52+00:00', 2, '[{\"changed\": {\"fields\": [\"Showtime id\", \"Voiceover\", \"Dubbing\"]}}]', 8, 1),
(7, '2021-01-02 16:00:16.771273', '8', '8 Forrest Gump 2021-01-02 16:00:06+00:00', 1, '[{\"added\": {}}]', 8, 1),
(8, '2021-01-02 16:00:26.483281', '6', '6 Forrest Gump 2021-01-02 16:00:14+00:00', 1, '[{\"added\": {}}]', 8, 1),
(9, '2021-01-02 16:13:11.403562', '5', '5 Forrest Gump 2020-12-30 14:27:52+00:00', 3, '', 8, 1),
(10, '2021-01-02 16:13:11.408788', '4', '4 Titanic 2020-12-31 06:00:00+00:00', 3, '', 8, 1),
(11, '2021-01-02 16:13:11.411885', '3', '3 Ojciec chrzestny 2020-12-15 00:00:00+00:00', 3, '', 8, 1),
(12, '2021-01-02 16:13:11.415600', '2', '2 Skazani na Shawshank 2020-12-30 19:26:59+00:00', 3, '', 8, 1),
(13, '2021-01-02 16:13:11.419110', '1', '1 Forrest Gump 2020-12-30 20:02:18+00:00', 3, '', 8, 1),
(14, '2021-01-02 16:30:35.319426', '6', '6 Forrest Gump 2021-01-02 16:00:14+00:00', 3, '', 8, 1),
(15, '2021-01-02 16:36:47.969563', '6', '6 Forrest Gump 2021-01-02 16:00:14+00:00', 3, '', 8, 1),
(16, '2021-01-02 16:39:10.194118', '6', '6 Forrest Gump 2021-01-02 16:00:14+00:00', 3, '', 8, 1),
(17, '2021-01-02 16:41:18.621149', '6', '6 Forrest Gump 2021-01-02 16:00:14+00:00', 3, '', 8, 1),
(18, '2021-01-02 16:41:34.580253', '9', '9 Forrest Gump 2020-12-30 14:27:52+00:00', 3, '', 8, 1),
(19, '2021-01-02 16:41:34.583771', '8', '8 Forrest Gump 2021-01-02 16:00:06+00:00', 3, '', 8, 1),
(20, '2021-01-02 16:44:49.017703', '1', '1 Forrest Gump 2021-01-02 16:44:06+00:00', 1, '[{\"added\": {}}]', 8, 1),
(21, '2021-01-02 16:45:25.235115', '1', '1 Forrest Gump 2021-01-02 16:44:06+00:00', 3, '', 8, 1),
(22, '2021-01-02 16:48:40.989284', '1', '1 Forrest Gump 2021-01-02 16:48:30+00:00', 1, '[{\"added\": {}}]', 8, 1),
(23, '2021-01-03 10:54:58.628950', '2', '2 Skazani na Shawshank 2021-01-03 10:54:44+00:00', 1, '[{\"added\": {}}]', 8, 1),
(24, '2021-01-03 11:00:59.725487', '3', '3 Forrest Gump 2021-01-04 11:00:49+00:00', 1, '[{\"added\": {}}]', 8, 1),
(25, '2021-01-04 13:18:40.801683', '11', '11 Titanic 2021-01-04 13:30:00+00:00', 1, '[{\"added\": {}}]', 8, 1),
(26, '2021-01-04 13:19:08.181590', '5', '5 Forrest Gump 2021-01-04 15:00:00+00:00', 1, '[{\"added\": {}}]', 8, 1),
(27, '2021-01-04 13:41:20.577838', '6', '6 Forrest Gump 2021-01-13 13:41:12+00:00', 1, '[{\"added\": {}}]', 8, 1),
(28, '2021-01-04 13:42:49.261668', '7', '7 Forrest Gump 2021-01-19 13:42:36+00:00', 1, '[{\"added\": {}}]', 8, 1),
(29, '2021-01-05 14:50:42.023810', '1', '1 Skazani na Shawshank 2021-01-05 14:50:31+00:00', 1, '[{\"added\": {}}]', 8, 1),
(30, '2021-01-05 14:52:28.532869', '17', '17 Skazani na Shawshank 2021-01-05 14:52:10+00:00', 1, '[{\"added\": {}}]', 8, 1),
(31, '2021-01-05 14:52:29.617977', '1', '1 Skazani na Shawshank 2021-01-05 14:50:31+00:00', 3, '', 8, 1),
(32, '2021-01-05 14:53:10.677191', '17', '17 Skazani na Shawshank 2021-01-05 14:52:10+00:00', 3, '', 8, 1),
(33, '2021-01-05 14:53:57.364974', '19', '19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 1, '[{\"added\": {}}]', 8, 1),
(34, '2021-01-09 16:23:07.961511', '63', '63', 3, '', 11, 1),
(35, '2021-01-09 16:23:07.967893', '62', '62', 3, '', 11, 1),
(36, '2021-01-09 16:23:07.972691', '61', '61', 3, '', 11, 1),
(37, '2021-01-09 16:23:07.978024', '60', '60', 3, '', 11, 1),
(38, '2021-01-09 16:23:07.984003', '59', '59', 3, '', 11, 1),
(39, '2021-01-09 16:23:07.989283', '58', '58', 3, '', 11, 1),
(40, '2021-01-09 16:23:07.993942', '57', '57', 3, '', 11, 1),
(41, '2021-01-09 16:23:07.999149', '56', '56', 3, '', 11, 1),
(42, '2021-01-09 16:23:08.004209', '55', '55', 3, '', 11, 1),
(43, '2021-01-09 16:23:08.010236', '54', '54', 3, '', 11, 1),
(44, '2021-01-09 16:23:08.017249', '53', '53', 3, '', 11, 1),
(45, '2021-01-09 16:23:08.022480', '52', '52', 3, '', 11, 1),
(46, '2021-01-09 16:23:08.026620', '51', '51', 3, '', 11, 1),
(47, '2021-01-09 16:23:08.031057', '50', '50', 3, '', 11, 1),
(48, '2021-01-09 16:23:08.034341', '49', '49', 3, '', 11, 1),
(49, '2021-01-09 16:23:08.037479', '48', '48', 3, '', 11, 1),
(50, '2021-01-09 16:23:08.040547', '47', '47', 3, '', 11, 1),
(51, '2021-01-09 16:23:08.045380', '46', '46', 3, '', 11, 1),
(52, '2021-01-09 16:23:08.049061', '45', '45', 3, '', 11, 1),
(53, '2021-01-09 16:23:08.052514', '44', '44', 3, '', 11, 1),
(54, '2021-01-09 16:23:08.055485', '43', '43', 3, '', 11, 1),
(55, '2021-01-09 16:23:08.060040', '42', '42', 3, '', 11, 1),
(56, '2021-01-09 16:23:08.065158', '41', '41', 3, '', 11, 1),
(57, '2021-01-09 16:23:08.069471', '40', '40', 3, '', 11, 1),
(58, '2021-01-09 16:23:08.080600', '39', '39', 3, '', 11, 1),
(59, '2021-01-09 16:23:08.084889', '38', '38', 3, '', 11, 1),
(60, '2021-01-09 16:23:08.089548', '37', '37', 3, '', 11, 1),
(61, '2021-01-09 16:23:08.094417', '36', '36', 3, '', 11, 1),
(62, '2021-01-09 16:23:08.098989', '35', '35', 3, '', 11, 1),
(63, '2021-01-09 16:23:08.103012', '34', '34', 3, '', 11, 1),
(64, '2021-01-09 16:23:08.106471', '33', '33', 3, '', 11, 1),
(65, '2021-01-09 16:23:08.110129', '32', '32', 3, '', 11, 1),
(66, '2021-01-09 16:23:08.113691', '31', '31', 3, '', 11, 1),
(67, '2021-01-09 16:23:18.231030', '280', '20 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(68, '2021-01-09 16:23:18.235557', '279', '19 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(69, '2021-01-09 16:23:18.239620', '278', '18 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(70, '2021-01-09 16:23:18.244018', '277', '17 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(71, '2021-01-09 16:23:18.248320', '276', '16 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(72, '2021-01-09 16:23:18.252431', '275', '15 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(73, '2021-01-09 16:23:18.256064', '274', '14 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(74, '2021-01-09 16:23:18.260226', '273', '13 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(75, '2021-01-09 16:23:18.266363', '272', '12 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(76, '2021-01-09 16:23:18.272581', '271', '11 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(77, '2021-01-09 16:23:18.277018', '270', '10 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(78, '2021-01-09 16:23:18.280431', '269', '9 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(79, '2021-01-09 16:23:18.285105', '268', '8 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(80, '2021-01-09 16:23:18.288978', '267', '7 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(81, '2021-01-09 16:23:18.292102', '266', '6 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(82, '2021-01-09 16:23:18.298241', '265', '5 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(83, '2021-01-09 16:23:18.302596', '264', '4 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(84, '2021-01-09 16:23:18.305681', '263', '3 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(85, '2021-01-09 16:23:18.309636', '262', '2 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(86, '2021-01-09 16:23:18.313983', '261', '1 19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 10, 1),
(87, '2021-01-09 16:23:18.317605', '220', '20 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(88, '2021-01-09 16:23:18.321062', '219', '19 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(89, '2021-01-09 16:23:18.324706', '218', '18 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(90, '2021-01-09 16:23:18.328431', '217', '17 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(91, '2021-01-09 16:23:18.332192', '216', '16 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(92, '2021-01-09 16:23:18.335424', '215', '15 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(93, '2021-01-09 16:23:18.339207', '214', '14 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(94, '2021-01-09 16:23:18.344089', '213', '13 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(95, '2021-01-09 16:23:18.348559', '212', '12 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(96, '2021-01-09 16:23:18.352367', '211', '11 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(97, '2021-01-09 16:23:18.355604', '210', '10 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(98, '2021-01-09 16:23:18.358812', '209', '9 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(99, '2021-01-09 16:23:18.363038', '208', '8 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(100, '2021-01-09 16:23:18.367831', '207', '7 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(101, '2021-01-09 16:23:18.372360', '206', '6 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(102, '2021-01-09 16:23:18.376707', '205', '5 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(103, '2021-01-09 16:23:18.381095', '204', '4 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(104, '2021-01-09 16:23:18.385638', '203', '3 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(105, '2021-01-09 16:23:18.389254', '202', '2 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(106, '2021-01-09 16:23:18.392639', '201', '1 7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 10, 1),
(107, '2021-01-09 16:23:18.395973', '200', '20 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(108, '2021-01-09 16:23:18.398516', '199', '19 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(109, '2021-01-09 16:23:18.402054', '198', '18 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(110, '2021-01-09 16:23:18.405097', '197', '17 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(111, '2021-01-09 16:23:18.408841', '196', '16 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(112, '2021-01-09 16:23:18.419504', '195', '15 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(113, '2021-01-09 16:23:18.424698', '194', '14 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(114, '2021-01-09 16:23:18.428658', '193', '13 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(115, '2021-01-09 16:23:18.433897', '192', '12 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(116, '2021-01-09 16:23:18.438129', '191', '11 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(117, '2021-01-09 16:23:18.442131', '190', '10 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(118, '2021-01-09 16:23:18.446468', '189', '9 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(119, '2021-01-09 16:23:18.450414', '188', '8 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(120, '2021-01-09 16:23:18.455820', '187', '7 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(121, '2021-01-09 16:23:18.459856', '186', '6 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(122, '2021-01-09 16:23:18.463542', '185', '5 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(123, '2021-01-09 16:23:18.467474', '184', '4 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(124, '2021-01-09 16:23:18.471247', '183', '3 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(125, '2021-01-09 16:23:18.475957', '182', '2 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(126, '2021-01-09 16:23:18.479213', '181', '1 6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 10, 1),
(127, '2021-01-09 16:23:36.257805', '19', '19 Skazani na Shawshank 2021-01-20 14:53:43+00:00', 3, '', 8, 1),
(128, '2021-01-09 16:23:36.264968', '7', '7 Forrest Gump 2021-01-19 13:42:36+00:00', 3, '', 8, 1),
(129, '2021-01-09 16:23:36.269015', '6', '6 Forrest Gump 2021-01-13 13:41:12+00:00', 3, '', 8, 1),
(130, '2021-01-09 16:23:59.505852', '1', '1 Forrest Gump 2021-01-30 16:23:47+00:00', 1, '[{\"added\": {}}]', 8, 1),
(131, '2021-01-09 16:24:24.669975', '2', '2 Skazani na Shawshank 2021-01-31 16:24:13+00:00', 1, '[{\"added\": {}}]', 8, 1),
(132, '2021-01-10 08:52:07.848715', '3', '3 Ojciec chrzestny 2021-01-14 08:51:56+00:00', 1, '[{\"added\": {}}]', 8, 1),
(133, '2021-01-10 17:58:51.761922', '4', '4 Forrest Gump 2021-01-31 17:58:45+00:00', 1, '[{\"added\": {}}]', 8, 1),
(134, '2021-01-10 18:00:25.872143', '4', '4 Forrest Gump 2021-01-31 17:58:45+00:00', 3, '', 8, 1),
(135, '2021-01-10 18:00:41.367883', '4', '4 Forrest Gump 2021-01-31 18:00:34+00:00', 1, '[{\"added\": {}}]', 8, 1),
(136, '2021-01-10 18:02:03.242528', '4', '4 Forrest Gump 2021-01-31 18:00:34+00:00', 3, '', 8, 1),
(137, '2021-01-10 18:02:16.534510', '4', '4 Forrest Gump 2021-01-31 18:02:10+00:00', 1, '[{\"added\": {}}]', 8, 1),
(138, '2021-01-10 18:03:05.970980', '4', '4 Forrest Gump 2021-01-31 18:02:10+00:00', 3, '', 8, 1),
(139, '2021-01-10 18:03:20.836566', '4', '4 Forrest Gump 2021-01-31 18:03:15+00:00', 1, '[{\"added\": {}}]', 8, 1),
(140, '2021-01-10 18:04:25.314602', '4', '4 Forrest Gump 2021-01-31 18:03:15+00:00', 3, '', 8, 1),
(141, '2021-01-10 18:04:38.812601', '4', '4 Forrest Gump 2021-01-31 18:04:33+00:00', 1, '[{\"added\": {}}]', 8, 1),
(142, '2021-01-10 18:05:24.798326', '4', '4 Forrest Gump 2021-01-31 18:04:33+00:00', 3, '', 8, 1),
(143, '2021-01-10 18:05:37.982119', '4', '4 Forrest Gump 2021-01-31 18:05:32+00:00', 1, '[{\"added\": {}}]', 8, 1),
(144, '2021-01-11 14:33:24.033107', '3', '3 Ojciec chrzestny 2021-01-14 08:51:56+00:00', 3, '', 8, 1),
(145, '2021-01-11 14:33:24.039211', '2', '2 Skazani na Shawshank 2021-01-31 16:24:13+00:00', 3, '', 8, 1),
(146, '2021-01-11 14:33:24.043123', '1', '1 Forrest Gump 2021-01-30 16:23:47+00:00', 3, '', 8, 1),
(147, '2021-01-11 14:33:45.811805', '1', '1 Forrest Gump 2021-01-11 20:33:31+00:00', 1, '[{\"added\": {}}]', 8, 1),
(148, '2021-01-11 14:34:03.595220', '2', '2 Skazani na Shawshank 2021-01-26 14:33:55+00:00', 1, '[{\"added\": {}}]', 8, 1),
(149, '2021-01-11 14:34:38.843298', '3', '3 Titanic 2021-01-29 14:34:28+00:00', 1, '[{\"added\": {}}]', 8, 1),
(150, '2021-02-03 08:58:26.387060', '8', '8 Forrest Gump 2021-02-03 08:58:12+00:00', 1, '[{\"added\": {}}]', 8, 1),
(151, '2021-02-03 08:58:59.151140', '8', '8 Forrest Gump 2021-02-03 08:58:12+00:00', 2, '[]', 8, 1),
(152, '2021-02-03 08:59:39.307084', '5', '5 Forrest Gump 2021-02-04 08:59:27+00:00', 1, '[{\"added\": {}}]', 8, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'kino', 'hall'),
(7, 'kino', 'movie'),
(8, 'kino', 'movieshowtime'),
(10, 'kino', 'seat'),
(11, 'kino', 'ticket'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2020-12-29 17:49:10.876209'),
(2, 'auth', '0001_initial', '2020-12-29 17:49:11.031015'),
(3, 'admin', '0001_initial', '2020-12-29 17:49:11.391489'),
(4, 'admin', '0002_logentry_remove_auto_add', '2020-12-29 17:49:11.508585'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2020-12-29 17:49:11.525916'),
(6, 'contenttypes', '0002_remove_content_type_name', '2020-12-29 17:49:11.645754'),
(7, 'auth', '0002_alter_permission_name_max_length', '2020-12-29 17:49:11.714669'),
(8, 'auth', '0003_alter_user_email_max_length', '2020-12-29 17:49:11.757535'),
(9, 'auth', '0004_alter_user_username_opts', '2020-12-29 17:49:11.775327'),
(10, 'auth', '0005_alter_user_last_login_null', '2020-12-29 17:49:11.836604'),
(11, 'auth', '0006_require_contenttypes_0002', '2020-12-29 17:49:11.842364'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2020-12-29 17:49:11.864862'),
(13, 'auth', '0008_alter_user_username_max_length', '2020-12-29 17:49:11.936363'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2020-12-29 17:49:11.996063'),
(15, 'auth', '0010_alter_group_name_max_length', '2020-12-29 17:49:12.030191'),
(16, 'auth', '0011_update_proxy_permissions', '2020-12-29 17:49:12.045487'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2020-12-29 17:49:12.114038'),
(18, 'sessions', '0001_initial', '2020-12-29 17:49:12.139936');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('hqbbjhnnof0mfa3xh3uvsgkfouci284w', '.eJxVjDsOgzAQRO_iOrLw36RMzxms9e4Sk0RGwlBFuXtAokiqkea9mbdIsK0lbY2XNJG4CiUuv10GfHI9AD2g3meJc12XKctDkSdtcpiJX7fT_Tso0Mq-NjlEUBy1YhoVBx1NANA-ZiQbx84Y6tgB7RnQBbAZOWLPHrRzvrfi8wXw_zg3:1kuYBV:eF0mPG8osoAljUqa7n_bR-dytYIz32H5rgVdZZ2csUM', '2021-01-13 09:54:25.203590'),
('m3gz2x5hlv7c9lizc2kl40x2up0mv95w', '.eJxVjDsOgzAQRO_iOrLw36RMzxms9e4Sk0RGwlBFuXtAokiqkea9mbdIsK0lbY2XNJG4CiUuv10GfHI9AD2g3meJc12XKctDkSdtcpiJX7fT_Tso0Mq-NjlEUBy1YhoVBx1NANA-ZiQbx84Y6tgB7RnQBbAZOWLPHrRzvrfi8wXw_zg3:1kvhUL:aue9UNgizMTyjAIE7hDXFz8_akaO51vIU8cMOTpZBbE', '2021-01-16 14:02:37.364105'),
('q9hsityj7ppmu65ohmg8kttwvgicbfzy', '.eJxVjDsOgzAQRO_iOrLw36RMzxms9e4Sk0RGwlBFuXtAokiqkea9mbdIsK0lbY2XNJG4CiUuv10GfHI9AD2g3meJc12XKctDkSdtcpiJX7fT_Tso0Mq-NjlEUBy1YhoVBx1NANA-ZiQbx84Y6tgB7RnQBbAZOWLPHrRzvrfi8wXw_zg3:1l7Dz0:Qm36itfFMM3bK9MKkFUIXjZ2D_o7sWhWb4cyqUA45hg', '2021-02-17 08:57:54.922280'),
('sbuztspcret8sv882npbui86qr51vjlj', '.eJxVjDsOgzAQRO_iOrLw36RMzxms9e4Sk0RGwlBFuXtAokiqkea9mbdIsK0lbY2XNJG4CiUuv10GfHI9AD2g3meJc12XKctDkSdtcpiJX7fT_Tso0Mq-NjlEUBy1YhoVBx1NANA-ZiQbx84Y6tgB7RnQBbAZOWLPHrRzvrfi8wXw_zg3:1kuJmC:N-yp9VQWI2Dt_RI-6ILTlqIgFOF_xSRyJ8_XaG-y4Wg', '2021-01-12 18:31:20.812895');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `hall`
--

CREATE TABLE `hall` (
  `hall_ID` int NOT NULL,
  `seats_number` int DEFAULT NULL,
  `hall_category` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `hall`
--

INSERT INTO `hall` (`hall_ID`, `seats_number`, `hall_category`) VALUES
(1, 20, '3D'),
(2, 20, '3D'),
(3, 20, '2D'),
(4, 20, '2D');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movie`
--

CREATE TABLE `movie` (
  `movie_ID` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `length` int DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `language` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `director` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `movie`
--

INSERT INTO `movie` (`movie_ID`, `title`, `length`, `rating`, `language`, `director`, `genre`) VALUES
(1, 'Forrest Gump', 142, '8.80', 'ENG', 'Robert Zemeckis', 'Dramat'),
(2, 'Skazani na Shawshank', 142, '9.30', 'ENG', 'Frank Darabont', 'Dramat'),
(3, 'Ojciec chrzestny', 175, '9.20', 'ENG', 'Francis Ford Coppola', 'Crime'),
(4, 'Titanic', 194, '7.30', 'ENG', 'James Cameron', 'Melodramat'),
(5, 'Dwunastu gniewnych ludzi', 96, '9.00', 'ENG', 'Sidney Lumet', 'Crime'),
(6, 'Podziemny krąg', 139, '8.80', 'ENG', 'David Fincher', 'Dramat'),
(7, 'Django', 165, '8.30', 'ENG', 'Quentin Tarantino', 'Western');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movie_showtime`
--

CREATE TABLE `movie_showtime` (
  `showtime_ID` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `movie_ID` int DEFAULT NULL,
  `hall_ID` int NOT NULL,
  `screening_category` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitles` tinyint DEFAULT NULL,
  `voiceover` tinyint DEFAULT NULL,
  `dubbing` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `movie_showtime`
--

INSERT INTO `movie_showtime` (`showtime_ID`, `date`, `movie_ID`, `hall_ID`, `screening_category`, `subtitles`, `voiceover`, `dubbing`) VALUES
(1, '2021-01-11 20:33:31', 1, 1, '3D', 1, 0, 0),
(2, '2021-01-26 14:33:55', 2, 4, '2D', 1, 0, 0),
(3, '2021-01-29 14:34:28', 4, 3, '2D', 1, 0, 0),
(4, '2021-01-31 18:05:32', 1, 3, '2D', 1, 0, 0),
(5, '2021-02-04 08:59:27', 1, 2, '2D', 1, 0, 0),
(8, '2021-02-03 08:58:12', 1, 1, '3D', 1, 0, 0);

--
-- Wyzwalacze `movie_showtime`
--
DELIMITER $$
CREATE TRIGGER `create_seats` AFTER INSERT ON `movie_showtime` FOR EACH ROW BEGIN
DECLARE v1 INT DEFAULT 0;
DECLARE v2 INT DEFAULT 0;
DECLARE max_seats INT;
DECLARE row_nmbr INT DEFAULT 0;
SELECT seats_number INTO max_seats FROM hall WHERE hall_ID = NEW.hall_ID;

WHILE v1 < max_seats DO
	IF (v1+1)%4=0 THEN SET v2 = v2+1;
    END IF;
    INSERT INTO seat (hall_ID, showtime_ID, seat_number, row_num, category)
    VALUES (NEW.hall_ID, NEW.showtime_ID, v1+1, v2+1, 'empty');
      SET v1 = v1 + 1;
END WHILE;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `seat`
--

CREATE TABLE `seat` (
  `seat_ID` int NOT NULL,
  `hall_ID` int DEFAULT NULL,
  `showtime_ID` int DEFAULT NULL,
  `seat_number` int NOT NULL,
  `row_num` int DEFAULT NULL,
  `category` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ;

--
-- Zrzut danych tabeli `seat`
--

INSERT INTO `seat` (`seat_ID`, `hall_ID`, `showtime_ID`, `seat_number`, `row_num`, `category`) VALUES
(441, 3, 4, 1, 1, 'empty'),
(442, 3, 4, 2, 1, 'empty'),
(443, 3, 4, 3, 1, 'empty'),
(444, 3, 4, 4, 2, 'empty'),
(445, 3, 4, 5, 2, 'empty'),
(446, 3, 4, 6, 2, 'empty'),
(447, 3, 4, 7, 2, 'not-empty'),
(448, 3, 4, 8, 3, 'empty'),
(449, 3, 4, 9, 3, 'empty'),
(450, 3, 4, 10, 3, 'empty'),
(451, 3, 4, 11, 3, 'empty'),
(452, 3, 4, 12, 4, 'empty'),
(453, 3, 4, 13, 4, 'empty'),
(454, 3, 4, 14, 4, 'not-empty'),
(455, 3, 4, 15, 4, 'not-empty'),
(456, 3, 4, 16, 5, 'not-empty'),
(457, 3, 4, 17, 5, 'empty'),
(458, 3, 4, 18, 5, 'empty'),
(459, 3, 4, 19, 5, 'not-empty'),
(460, 3, 4, 20, 6, 'not-empty'),
(461, 1, 1, 1, 1, 'not-empty'),
(462, 1, 1, 2, 1, 'empty'),
(463, 1, 1, 3, 1, 'empty'),
(464, 1, 1, 4, 2, 'empty'),
(465, 1, 1, 5, 2, 'empty'),
(466, 1, 1, 6, 2, 'not-empty'),
(467, 1, 1, 7, 2, 'empty'),
(468, 1, 1, 8, 3, 'empty'),
(469, 1, 1, 9, 3, 'empty'),
(470, 1, 1, 10, 3, 'not-empty'),
(471, 1, 1, 11, 3, 'not-empty'),
(472, 1, 1, 12, 4, 'empty'),
(473, 1, 1, 13, 4, 'empty'),
(474, 1, 1, 14, 4, 'empty'),
(475, 1, 1, 15, 4, 'not-empty'),
(476, 1, 1, 16, 5, 'empty'),
(477, 1, 1, 17, 5, 'not-empty'),
(478, 1, 1, 18, 5, 'empty'),
(479, 1, 1, 19, 5, 'empty'),
(480, 1, 1, 20, 6, 'empty'),
(481, 4, 2, 1, 1, 'empty'),
(482, 4, 2, 2, 1, 'empty'),
(483, 4, 2, 3, 1, 'empty'),
(484, 4, 2, 4, 2, 'empty'),
(485, 4, 2, 5, 2, 'empty'),
(486, 4, 2, 6, 2, 'empty'),
(487, 4, 2, 7, 2, 'empty'),
(488, 4, 2, 8, 3, 'empty'),
(489, 4, 2, 9, 3, 'empty'),
(490, 4, 2, 10, 3, 'not-empty'),
(491, 4, 2, 11, 3, 'empty'),
(492, 4, 2, 12, 4, 'empty'),
(493, 4, 2, 13, 4, 'empty'),
(494, 4, 2, 14, 4, 'empty'),
(495, 4, 2, 15, 4, 'empty'),
(496, 4, 2, 16, 5, 'empty'),
(497, 4, 2, 17, 5, 'empty'),
(498, 4, 2, 18, 5, 'empty'),
(499, 4, 2, 19, 5, 'empty'),
(500, 4, 2, 20, 6, 'empty'),
(501, 3, 3, 1, 1, 'empty'),
(502, 3, 3, 2, 1, 'empty'),
(503, 3, 3, 3, 1, 'empty'),
(504, 3, 3, 4, 2, 'empty'),
(505, 3, 3, 5, 2, 'empty'),
(506, 3, 3, 6, 2, 'empty'),
(507, 3, 3, 7, 2, 'empty'),
(508, 3, 3, 8, 3, 'empty'),
(509, 3, 3, 9, 3, 'empty'),
(510, 3, 3, 10, 3, 'empty'),
(511, 3, 3, 11, 3, 'empty'),
(512, 3, 3, 12, 4, 'empty'),
(513, 3, 3, 13, 4, 'empty'),
(514, 3, 3, 14, 4, 'empty'),
(515, 3, 3, 15, 4, 'empty'),
(516, 3, 3, 16, 5, 'empty'),
(517, 3, 3, 17, 5, 'empty'),
(518, 3, 3, 18, 5, 'empty'),
(519, 3, 3, 19, 5, 'empty'),
(520, 3, 3, 20, 6, 'empty'),
(521, 1, 8, 1, 1, 'empty'),
(522, 1, 8, 2, 1, 'empty'),
(523, 1, 8, 3, 1, 'empty'),
(524, 1, 8, 4, 2, 'empty'),
(525, 1, 8, 5, 2, 'empty'),
(526, 1, 8, 6, 2, 'empty'),
(527, 1, 8, 7, 2, 'empty'),
(528, 1, 8, 8, 3, 'empty'),
(529, 1, 8, 9, 3, 'empty'),
(530, 1, 8, 10, 3, 'empty'),
(531, 1, 8, 11, 3, 'empty'),
(532, 1, 8, 12, 4, 'empty'),
(533, 1, 8, 13, 4, 'empty'),
(534, 1, 8, 14, 4, 'empty'),
(535, 1, 8, 15, 4, 'empty'),
(536, 1, 8, 16, 5, 'empty'),
(537, 1, 8, 17, 5, 'empty'),
(538, 1, 8, 18, 5, 'empty'),
(539, 1, 8, 19, 5, 'empty'),
(540, 1, 8, 20, 6, 'empty'),
(541, 2, 5, 1, 1, 'empty'),
(542, 2, 5, 2, 1, 'empty'),
(543, 2, 5, 3, 1, 'empty'),
(544, 2, 5, 4, 2, 'empty'),
(545, 2, 5, 5, 2, 'empty'),
(546, 2, 5, 6, 2, 'empty'),
(547, 2, 5, 7, 2, 'empty'),
(548, 2, 5, 8, 3, 'empty'),
(549, 2, 5, 9, 3, 'empty'),
(550, 2, 5, 10, 3, 'not-empty'),
(551, 2, 5, 11, 3, 'empty'),
(552, 2, 5, 12, 4, 'empty'),
(553, 2, 5, 13, 4, 'empty'),
(554, 2, 5, 14, 4, 'empty'),
(555, 2, 5, 15, 4, 'empty'),
(556, 2, 5, 16, 5, 'empty'),
(557, 2, 5, 17, 5, 'empty'),
(558, 2, 5, 18, 5, 'empty'),
(559, 2, 5, 19, 5, 'empty'),
(560, 2, 5, 20, 6, 'empty');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ticket`
--

CREATE TABLE `ticket` (
  `ticket_ID` int NOT NULL,
  `seat_ID` int DEFAULT NULL,
  `showtime_ID` int DEFAULT NULL,
  `price` decimal(4,2) DEFAULT NULL,
  `price_category` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `ticket`
--

INSERT INTO `ticket` (`ticket_ID`, `seat_ID`, `showtime_ID`, `price`, `price_category`) VALUES
(113, 455, 4, '15.00', 'ULGOWY'),
(114, 456, 4, '15.00', 'ULGOWY'),
(115, 459, 4, '15.00', 'ULGOWY'),
(116, 461, 1, '15.00', 'ULGOWY'),
(117, 460, 4, '15.00', 'ULGOWY'),
(118, 471, 1, '15.00', 'ULGOWY'),
(119, 466, 1, '15.00', 'ULGOWY'),
(120, 470, 1, '15.00', 'ULGOWY'),
(121, 477, 1, '15.00', 'ULGOWY'),
(122, 447, 4, '15.00', 'ULGOWY'),
(123, 475, 1, '15.00', 'ULGOWY'),
(124, 454, 4, '15.00', 'ULGOWY'),
(125, 490, 2, '15.00', 'ULGOWY'),
(126, 550, 5, '15.00', 'ULGOWY');

--
-- Wyzwalacze `ticket`
--
DELIMITER $$
CREATE TRIGGER `Add_Price_Trigger` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN

END
$$
DELIMITER ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indeksy dla tabeli `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeksy dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indeksy dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indeksy dla tabeli `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indeksy dla tabeli `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indeksy dla tabeli `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`hall_ID`);

--
-- Indeksy dla tabeli `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_ID`);

--
-- Indeksy dla tabeli `movie_showtime`
--
ALTER TABLE `movie_showtime`
  ADD PRIMARY KEY (`showtime_ID`),
  ADD KEY `movie_ID_showtime_idx` (`movie_ID`),
  ADD KEY `hall_ID_showtime_idx` (`hall_ID`);

--
-- Indeksy dla tabeli `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`seat_ID`),
  ADD KEY `hall_ID_seat_idx` (`hall_ID`);

--
-- Indeksy dla tabeli `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_ID`),
  ADD KEY `seat_ID_ticket_idx` (`seat_ID`),
  ADD KEY `showtime_ID_ticket_idx` (`showtime_ID`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT dla tabeli `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT dla tabeli `movie`
--
ALTER TABLE `movie`
  MODIFY `movie_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `seat`
--
ALTER TABLE `seat`
  MODIFY `seat_ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ograniczenia dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ograniczenia dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `movie_showtime`
--
ALTER TABLE `movie_showtime`
  ADD CONSTRAINT `showtime_constraint_hall` FOREIGN KEY (`hall_ID`) REFERENCES `hall` (`hall_ID`),
  ADD CONSTRAINT `showtime_constraint_movie` FOREIGN KEY (`movie_ID`) REFERENCES `movie` (`movie_ID`);

--
-- Ograniczenia dla tabeli `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_constraint_seat` FOREIGN KEY (`seat_ID`) REFERENCES `seat` (`seat_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_constraint_showtime` FOREIGN KEY (`showtime_ID`) REFERENCES `movie_showtime` (`showtime_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
