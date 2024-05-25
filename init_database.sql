-- Creation of a bank base...

CREATE DATABASE observatory;

USE observatory;

START TRANSACTION;

--
-- Структура таблицы `natural_objects`
--

CREATE TABLE `natural_objects` (
  `id` int(11) NOT NULL,
  `type` varchar(63) NOT NULL,
  `galaxy` varchar(63) NOT NULL,
  `accuracy` float NOT NULL,
  `light_flow` int(11) NOT NULL,
  `related_objects` varchar(63) NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `objects`
--

CREATE TABLE `objects` (
  `id` int(11) NOT NULL,
  `type` varchar(63) NOT NULL,
  `accuracy` float NOT NULL,
  `amount` int(11) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `objects_relations`
--

CREATE TABLE `objects_relations` (
  `id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `natural_object_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `positions`
--

CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `earth_position` point NOT NULL,
  `sun_position` point NOT NULL,
  `moon_position` point NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `sectors`
--

CREATE TABLE `sectors` (
  `id` int(11) NOT NULL,
  `coords` point NOT NULL,
  `light_intensity` int(11) NOT NULL,
  `foreign_objects` varchar(63) NOT NULL,
  `amount_of_objects` int(11) NOT NULL,
  `unknown_amount` int(11) NOT NULL,
  `specified_amount` int(11) NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `natural_objects`
--
ALTER TABLE `natural_objects`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `objects_relations`
--
ALTER TABLE `objects_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_id` (`object_id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `position_id` (`position_id`),
  ADD KEY `natural_object_id` (`natural_object_id`);

--
-- Индексы таблицы `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sectors`
--
ALTER TABLE `sectors`
  ADD PRIMARY KEY (`id`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `objects_relations`
--
ALTER TABLE `objects_relations`
  ADD CONSTRAINT `objects_relations_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  ADD CONSTRAINT `objects_relations_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `objects_relations_ibfk_3` FOREIGN KEY (`natural_object_id`) REFERENCES `natural_objects` (`id`),
  ADD CONSTRAINT `objects_relations_ibfk_4` FOREIGN KEY (`sector_id`) REFERENCES `sectors` (`id`);
COMMIT;
