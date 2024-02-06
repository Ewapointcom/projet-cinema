-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 06 fév. 2024 à 05:29
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cinema`
--

-- --------------------------------------------------------

--
-- Structure de la table `cinema`
--

DROP TABLE IF EXISTS `cinema`;
CREATE TABLE IF NOT EXISTS `cinema` (
  `idCinema` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nomCinema` varchar(255) NOT NULL,
  PRIMARY KEY (`idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `cinema`
--

INSERT INTO `cinema` (`idCinema`, `nomCinema`) VALUES
(1, 'SEINE-ET-MARNE'),
(2, 'SEINE-SAINT-DENIS');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCinema` int UNSIGNED DEFAULT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `email` varchar(100) NOT NULL,
  `passeword` binary(5) NOT NULL,
  PRIMARY KEY (`idClient`),
  KEY `idCinema` (`idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`idClient`, `idCinema`, `nom`, `prenom`, `email`, `passeword`) VALUES
(1, 1, 'Dupont', 'Aline', 'Aline_Dupont@gmail.com', 0x0100000000),
(2, 1, 'Durand', 'Alexis', 'alexis_durand@gmail.com', 0x0200000000),
(3, 2, 'Lejeune', 'Pierre', 'pierre_lejeune@gmail.com', 0x0300000000),
(4, 2, 'Lee', 'Sam', 'sam_lee@gmail.com', 0x0400000000);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `idEmploye` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCinema` int UNSIGNED NOT NULL,
  `idSeance` int UNSIGNED NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`idEmploye`),
  KEY `idSeance` (`idSeance`),
  KEY `idCinema` (`idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`idEmploye`, `idCinema`, `idSeance`, `role`) VALUES
(103, 1, 0, 'GESTION'),
(104, 1, 0, 'VENTE'),
(105, 2, 0, 'GESTION'),
(106, 2, 0, 'VENTE');

-- --------------------------------------------------------

--
-- Structure de la table `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `idFilm` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) NOT NULL,
  PRIMARY KEY (`idFilm`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
    `idReservation` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `typeClient` varchar(50) NOT NULL,
    `tarifs` float NOT NULL,
    `paiement` varchar(255) NOT NULL,
    PRIMARY KEY (`idReservation`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`idReservation`, `typeClient`, `tarifs`, `paiement`) VALUES
(1, 'Plein Tarif', 9.2, 'Sur place'),
(8, 'Etudiant', 7.6, 'Sur Place'),
(9, 'Moins de 14 ans', 5.9, 'Sur place');

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

DROP TABLE IF EXISTS `salle`;
CREATE TABLE IF NOT EXISTS `salle` (
    `idSalle` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `numéro` int UNSIGNED NOT NULL,
    `capacité` int UNSIGNED NOT NULL,
    PRIMARY KEY (`idSalle`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `salle`
--

INSERT INTO `salle` (`idSalle`, `numéro`, `capacité`) VALUES
(5, 10, 120),
(6, 11, 150),
(7, 12, 200);

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

DROP TABLE IF EXISTS `seance`;
CREATE TABLE IF NOT EXISTS `seance` (
    `idSeance` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `idCinema` int UNSIGNED DEFAULT NULL,
    `idFilm` int UNSIGNED NOT NULL,
    `idSalle` int UNSIGNED NOT NULL,
    `idReservation` int UNSIGNED NOT NULL,
    `date` date NOT NULL,
    `heure` time NOT NULL,
    PRIMARY KEY (`idSeance`),
    KEY `idFilm` (`idFilm`),
    KEY `idSalle` (`idSalle`),
    KEY `idCinema` (`idCinema`),
    KEY `idReservation` (`idReservation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
    ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`idCinema`) REFERENCES `cinema` (`idCinema`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `employe`
--
ALTER TABLE `employe`
    ADD CONSTRAINT `employe_ibfk_1` FOREIGN KEY (`idCinema`) REFERENCES `cinema` (`idCinema`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `seance`
--
ALTER TABLE `seance`
    ADD CONSTRAINT `seance_ibfk_1` FOREIGN KEY (`idFilm`) REFERENCES `film` (`idFilm`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT `seance_ibfk_2` FOREIGN KEY (`idSalle`) REFERENCES `salle` (`idSalle`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT `seance_ibfk_4` FOREIGN KEY (`idCinema`) REFERENCES `cinema` (`idCinema`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT `seance_ibfk_5` FOREIGN KEY (`idReservation`) REFERENCES `reservation` (`idReservation`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
