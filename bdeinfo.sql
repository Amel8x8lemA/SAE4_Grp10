DROP DATABASE IF EXISTS bdeinfo;
CREATE DATABASE bdeinfo;
USE bdeinfo;

DROP TABLE IF EXISTS `product_size`;
DROP TABLE IF EXISTS `product_color`;
DROP TABLE IF EXISTS `color`;
DROP TABLE IF EXISTS `transactionContent`;
DROP TABLE IF EXISTS `transaction`;
DROP TABLE IF EXISTS `inscription`;
DROP TABLE IF EXISTS `usersToRenew`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `event`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `grade`;

CREATE TABLE `event` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `price` float,
  `date` datetime,
  `image` varchar(255)
);

CREATE TABLE `grade` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `price` integer
);

CREATE TABLE `user` (
  `email` varchar(255) PRIMARY KEY,
  `username` varchar(255),
  `password` varchar(255),
  `category` varchar(255),
  `xp` integer,
  `grade` integer,
  `dc_id` varchar(255),
  `dc_pfp` varchar(255),
  `dc_username` varchar(255),
  FOREIGN KEY (`grade`) REFERENCES `grade` (`id`)
);

CREATE TABLE `usersToRenew` (
  `user` varchar(255) PRIMARY KEY,
  `grade` integer,
  FOREIGN KEY (`user`) REFERENCES `user` (`email`),
  FOREIGN KEY (`grade`) REFERENCES `grade` (`id`)
);

CREATE TABLE `inscription` (
  `user` varchar(255),
  `event_id` integer,
  PRIMARY KEY (`user`, `event_id`),
  FOREIGN KEY (`user`) REFERENCES `user` (`email`),
  FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
);

CREATE TABLE `product` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `price` float,
  `description` varchar(255),
  `image` varchar(255),
  `release_date` datetime,
  `expire_date` datetime,
  `confirm_threashold` integer,
  `color` varchar(255),
  `is_promoted` int(1)
);

CREATE TABLE `color` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `product_color` (
  `product_id` int,
  `color_id` int,
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  FOREIGN KEY (`color_id`) REFERENCES `color` (`id`)
);

CREATE TABLE `product_size` (
  `product_id` int,
  `name` varchar(255),
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
);

CREATE TABLE `transaction` (
  `transaction_id` varchar(255) PRIMARY KEY,
  `email` varchar(255),
  `validated` int(1),
  `total_price` float,
  `purchase_date` datetime,
  FOREIGN KEY (`email`) REFERENCES `user` (`email`)
);

CREATE TABLE `transactionContent` (
  `transaction_id` varchar(255),
  `event_id` int,
  `grade_id` int,
  `product_id` int,
  `item_name` varchar(255),
  `item_price` float,
  `product_qty` int DEFAULT 1 CHECK(`product_qty` > 0),
  FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`),
  FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
);
























































-- color
INSERT INTO `color`
VALUES (1, 'rouge'),
  (2, 'bleu-marine');

-- grade
INSERT INTO `grade`
VALUES (0, 'Iron', 5),
  (1, 'Gold', 15),
  (2, 'Diamant', 25);

-- user
INSERT INTO `user`
VALUES (
    'John.Doe.Etu@univ-lemans.fr',
    'johnDoe',
    '4236441508',
    '21B',
    220,
    0,
    'NULL',
    'NULL',
    'NULL'
  ),
(
    'admin@univ-lemans.fr',
    'admin',
    '92668751',
    'admin',
    0,
    0,
    'NULL',
    'NULL',
    'NULL'
  ),
  (
    'Todd Smith',
    'Todd Smith',
    NULL,
    NULL,
    0,
    NULL,
    NULL,
    NULL,
    NULL
  );

-- product
INSERT INTO `product`
VALUES (
    1,
    'Produit supprimé',
    0,
    'Produit supprimé',
    '',
    '2024-01-24 19:00:00',
    '2024-01-24 20:00:00',
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    'Pull 2023-2024',
    27.5,
    'Le pull officiel du département informatique pour l\ année 2023-2024. Design par Mathéo Orgé.',
    'image-1706202613813.png',
    '2024-01-24 19:00:00',
    '2024-02-15 20:00:00',
    NULL,
    'bleu-marine',
    1
  ),
  (
    3,
    'Redbull',
    1,
    'Une canette de redbull de 25cl. Goût classic.',
    'image-1706120804285.png',
    '2024-01-24 19:00:00',
    '2024-06-30 23:59:00',
    NULL,
    NULL,
    0
  );


-- event
INSERT INTO `event`
VALUES (
    11028701,
    'Marché de Noël',
    -1,
    '2023-12-21 18:30:00',
    'marche_de_noel.webp'
  ),
  (
    49469041,
    'Goûter de rentrée',
    0,
    '2023-09-04 16:00:00',
    'gouter_de_rentree.webp'
  ),
  (
    226517193,
    'Gourde ADIIL',
    -1,
    '2023-11-06 08:00:00',
    'gourde.webp'
  ),
  (
    239501416,
    'Nuit de l\'info',
    0,
    '2023-12-07 15:38:00',
    'ndli.webp'
  ),
  (
    341554572,
    'Menu Maxi',
    4.5,
    '2023-12-07 09:00:00',
    'menu_maxi.webp'
  ),
  (
    383910450,
    'Soirée Haloween',
    -1,
    '2023-10-27 17:30:00',
    'soiree_haloween.webp'
  );

-- inscription
-- INSERT INTO `inscription`
-- VALUES ('', 801547147),
--   ('a', 239501416),
--   ('Adrien Derache V2', 1089493169),
--   ('AIT-LAHCEN ABDELADEM', 940575287),
--   ('AIT-LAHCEN ABDELADEM', 1567685583),
--   ('alex.lemoine.etu@univ-lemans.fr', 1946907562),
--   ('Alexandre ANTONIO', 341554572),
--   (
--     'alexandre.grasteau.etu@univ-lemans.fr',
--     485759472
--   );

-- product_color
INSERT INTO `product_color`
VALUES (2, 2);

-- product_size
INSERT INTO `product_size`
VALUES (2, 's'),
  (2, 'xl'),
  (2, ' xxl'),
  (2, ' l'),
  (2, ' m');

-- transaction
INSERT INTO `transaction`
VALUES (
    '02028300MP216124T',
    'John.Doe.Etu@univ-lemans.fr',
    1,
    NULL,
    '2024-01-21 22:38:18'
  );

-- transactionContent
INSERT INTO `transactionContent`
VALUES (
    '02028300MP216124T',
    NULL,
    NULL,
    2,
    'Pull 2023-2024(m)',
    27.5,
    1
  );




USE bdeinfo;
REVOKE ALL PRIVILEGES ON bdeinfo.* FROM 'etu'@'%';
GRANT SELECT, UPDATE, DELETE, INSERT ON bdeinfo.* TO 'etu'@'%' IDENTIFIED BY 'amego777';
flush privileges;