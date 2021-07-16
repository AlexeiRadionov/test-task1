-- 1. создаём базу данных
CREATE DATABASE training;

-- 2. создаём таблицы базы данных

-- 2.1 таблица стажёры
CREATE TABLE `training`.`trainee` 
(`trainee_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, 
`name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL, 
`email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL, 
PRIMARY KEY (`trainee_id`)) ENGINE = InnoDB;

-- 2.2 таблица курсы
CREATE TABLE `training`.`course` 
(`course_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, 
`name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL, 
`description` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL, 
PRIMARY KEY (`course_id`)) ENGINE = InnoDB;

-- 2.3 таблица история
CREATE TABLE `training`.`history` 
(`history_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, 
`trainee_id` INT(10) UNSIGNED NOT NULL, 
`course_id` INT(10) UNSIGNED NOT NULL, 
`start` DATE NOT NULL, 
`end` DATE NOT NULL, 
`status` TINYINT(4) NOT NULL, 
PRIMARY KEY (`history_id`)) ENGINE = InnoDB;

-- 3. заполняем таблицы данными

-- 3.1 таблица курсы
INSERT INTO `course` (`name`, `description`) VALUES 
('PHP', 'Описание курса PHP'),
('CSS', 'Описание курса CSS'),
('HTML', 'Описание курса HTML'),
('JS', 'Описание курса JS'),
('MySQL', 'Описание курса MySQL'),
('ReactJS', 'Описание курса ReactJS');

-- 3.2 таблица стажёры
INSERT INTO `trainee` (`name`, `email`) VALUES 
('Иванов', 'ivanov@mail.ru'),
('Петров', 'petrov@mail.ru'),
('Сидоров', 'sidorov@mail.ru'),
('Потапов', 'potapov@mail.ru'),
('Кутузов', 'kutuzov@mail.ru'),
('Жуков', 'zhukov@mail.ru');

-- 3.3 таблица история
INSERT INTO `history` 
(`trainee_id`, `course_id`, `start`, `end`, `status`) VALUES 
(1, 2, '2021-02-15', '2021-03-03', 1),
(2, 1, '2021-05-12', '2021-06-15', 1),
(5, 1, '2021-05-12', '2021-06-15', 0),
(3, 5, '2021-06-10', '2021-07-13', 1),
(6, 3, '2021-06-27', '2021-07-15', 1),
(4, 5, '2021-06-14', '2021-07-14', 1),
(2, 6, '2021-06-05', '2021-07-07', 0),
(1, 4, '2021-05-22', '2021-06-30', 0);

-- 4. выведем список стажёров, которые успешно прошли курс
-- по PHP в прошлом месяце
SELECT 
`trainee`.`name`, 
`trainee`.`email`, 
`course`.`name`, 
`history`.`end` 
FROM `course` JOIN `history` 
USING (`course_id`) 
RIGHT OUTER JOIN `trainee`
USING (`trainee_id`)
WHERE `course`.`name` = 'PHP' 
AND `history`.`end` >= '2021-06-01' 
AND `history`.`end` <= '2021-06-30' 
AND `history`.`status` = 1;

-- 5. выведем количество успешных прохождений курсов для 
-- каждого из курсов в текущем месяце
SELECT 
`course`.`name`, 
SUM(`history`.`status`) AS quantity 
FROM `course` JOIN `history` 
USING (`course_id`) 
WHERE `history`.`end` >= '2021-07-01' 
AND `history`.`end` <= '2021-07-31' 
AND `history`.`status` = 1 
GROUP BY `course`.`name`;