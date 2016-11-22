<?php
/*
upgrade_129.php - For users upgrading from DB version 1.2.9 to 1.3.0
Copyright (C) 2015 Stephen Lawrence Jr.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

global $pdo;

echo 'Altering the data table...<br />';
$query = "
ALTER TABLE {$_SESSION['db_prefix']}data
ADD COLUMN `rb_id` INT(11) NULL DEFAULT NULL,
ADD COLUMN `rb_operacion_id` INT(11) NULL DEFAULT NULL
";
$stmt = $pdo->prepare($query);
$stmt->execute();

echo 'Creating export_rp table...<br />';
$query = "
CREATE TABLE `{$_SESSION['db_prefix']}export_rp` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`data_id` INT(11) NOT NULL,
	`destination` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
";
$stmt = $pdo->prepare($query);
$stmt->execute();

$query = "
ALTER TABLE `{$_SESSION['db_prefix']}data`
	DROP INDEX `data_idx`,
	DROP INDEX `id`,
	DROP INDEX `id_2`,
	DROP INDEX `description`,
	DROP INDEX `publishable`;
";
$stmt = $pdo->prepare($query);
$stmt->execute();
