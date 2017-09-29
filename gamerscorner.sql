-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 29, 2017 at 09:57 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamerscorner`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Xbox One Games'),
(2, 'PS4 Games'),
(3, 'Nintendo Wii Games'),
(4, 'Xbox 360 Games'),
(5, 'PS3 Games');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `address` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `zipcode` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `product_id`, `user_id`, `transaction_id`, `qty`, `price`, `address`, `address2`, `city`, `state`, `zipcode`) VALUES
(1, 3, 1, '0', 1, '3990.00', 'Downtown, Dispur, Guwahati 781036.', '', 'Guwahati', 'Assam', '781036'),
(2, 2, 1, '0', 1, '2490.00', 'Downtown, Dispur, Guwahati 781036.', '', 'Guwahati', 'Assam', '781036');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `title`, `description`, `image`, `price`) VALUES
(1, 1, 'Watch Dogs 2', 'Watch Dogs 2 is an open world action-adventure video game developed and published by Ubisoft. The sequel to 2014\'s Watch Dogs.', 'watch_dogs2.jpg', '2999.99'),
(2, 1, 'Dishonored 2', 'Dishonored 2 is an action-adventure stealth video game developed by Arkane Studios and published by Bethesda Softworks. The sequel to 2012\'s Dishonored.\r\nAfter Empress Emily Kaldwin is deposed by an \"otherworldly usurper\", the player may choose between playing as either Emily or her Royal Protector and father Corvo Attano as they attempt to reclaim the throne. Both Emily and Corvo employ their own array of supernatural abilities. They can alternatively decide to forfeit them altogether. There are a multitude of ways to succeed in each given mission, from stealth to purposeful violent conflict.', 'dishonored2.jpg', '2490.00'),
(3, 2, 'Horizon Zero Dawn', 'Horizon Zero Dawn is an action role-playing video game developed by Guerrilla Games and published by Sony Interactive Entertainment for the PlayStation 4.\r\n\r\nThe plot revolves around Aloy, a hunter and archer who lives in a world overrun by robots. Having been cloistered her whole life, she sets out to discover the dangers that kept her sheltered for so long. The character makes use of ranged, melee weapons and stealth tactics to combat the mechanised creatures whose remains can also be looted for resources. A skill tree facilitates gameplay improvements. The game features an open world environment for Aloy to explore, divided into tribes that hold side quests to accomplish while the main story guides her throughout the whole world.', 'zero_dawn.jpg', '3990.00'),
(4, 1, 'Overwatch', 'Overwatch is a team-based multiplayer first-person shooter video game developed and published by Blizzard Entertainment.\r\n\r\nOverwatch puts players into two teams of six, with each player selecting one of several pre-defined hero characters with unique movement, attributes, and abilities; these heroes are divided into four classes. Players on a team work together to secure and defend control points on a map and/or escort a payload across the map in a limited amount of time.', 'overwatch.jpg', '3059.99'),
(5, 3, 'The Legend of Zelda: Twilight Princess HD', 'The Legend of Zelda: Twilight Princess HD is an action-adventure game in Nintendo\'s The Legend of Zelda series for the Wii U home video game console. A high-definition remaster of The Legend of Zelda: Twilight Princess. The game was co-developed by Tantalus and Nintendo Entertainment Planning & Development and published by Nintendo, and features enhanced graphics and Amiibo functionality. The release of the game marked the ten-year anniversary of the international release of the original.', 'zeldahd.jpg', '3999.99'),
(6, 5, 'Grand Theft Auto V', 'Grand Theft Auto V is an action-adventure video game developed by Rockstar North and published by Rockstar Games. It is the first main entry in the Grand Theft Auto series since 2008\'s Grand Theft Auto IV. Set within the fictional state of San Andreas, based on Southern California, the single-player story follows three criminals and their efforts to commit heists while under pressure from a government agency. The open world design lets players freely roam San Andreas\'s open countryside and the fictional city of Los Santos, based on Los Angeles.', 'gta5.jpg', '2599.99');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `join_date`) VALUES
(1, 'Ahmad W', 'Khan', 'oli@gmail.com', 'oli13', '827ccb0eea8a706c4c34a16891f84e7b', '2017-02-24 07:02:39'),
(3, 'Mariyam Jameelah', 'Khan', 'mj@gmail.com', 'jamu', '827ccb0eea8a706c4c34a16891f84e7b', '2017-02-25 15:41:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
