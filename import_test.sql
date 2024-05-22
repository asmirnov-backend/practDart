-- Creation of a bank base...

CREATE DATABASE bank;

USE bank;

START TRANSACTION;

CREATE TABLE `individuals` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(63) NOT NULL,
  `last_name` varchar(63) NOT NULL,
  `middle_name` varchar(63) NOT NULL,
  `passport_number` int(11) NOT NULL,
  `inn_number` int(11) NOT NULL,
  `snils_number` int(11) NOT NULL,
  `driver_license_number` int(11) NOT NULL,
  `additional_documents` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='физические лица';

CREATE TABLE `borrowers` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `inn_number` int(11) NOT NULL,
  `is_individual` tinyint(1) NOT NULL,
  `address` varchar(127) NOT NULL,
  `amount_total` float NOT NULL,
  `conditions` text NOT NULL,
  `legal_comments` text NOT NULL,
  `contracts` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='«Заёмщики»';

CREATE TABLE `credits` (
  `id` int(11) NOT NULL,
  `individual_id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `term` varchar(255) NOT NULL,
  `percent` float NOT NULL,
  `conditions` text NOT NULL,
  `comment` varchar(255) NOT NULL,
  `borrower_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='кредиты для организаций';


--
-- Индексы таблицы `credits`
--
ALTER TABLE `credits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `individual_id` (`individual_id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Ограничения внешнего ключа таблицы `credits`
--
ALTER TABLE `credits`
  ADD CONSTRAINT `credits_ibfk_1` FOREIGN KEY (`individual_id`) REFERENCES `individuals` (`id`),
  ADD CONSTRAINT `credits_ibfk_2` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

CREATE TABLE `money` (
  `id` int(11) NOT NULL,
  `individual_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `percent` float NOT NULL,
  `term` varchar(355) NOT NULL,
  `conditions` text NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='заёмные средства';

--
-- Индексы таблицы `money`
--
ALTER TABLE `money`
  ADD PRIMARY KEY (`id`),
  ADD KEY `individual_id` (`individual_id`);

--
-- Ограничения внешнего ключа таблицы `money`
--
ALTER TABLE `money`
  ADD CONSTRAINT `money_ibfk_1` FOREIGN KEY (`individual_id`) REFERENCES `individuals` (`id`);

COMMIT;
