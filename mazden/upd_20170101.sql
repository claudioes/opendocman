ALTER TABLE `odm_data`
    ADD COLUMN `rb_id` INT NULL DEFAULT NULL AFTER `reviewer_comments`,
    ADD COLUMN `rb_operacion_id` INT NULL DEFAULT NULL AFTER `rb_id`;

CREATE TABLE `odm_export_rp` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `data_id` INT(11) NOT NULL,
    `destination` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

ALTER TABLE `odm_data`
    DROP INDEX `id`,
    DROP INDEX `id_2`,
    DROP INDEX `data_idx`,
    DROP INDEX `description`,
    DROP INDEX `publishable`;

ALTER TABLE `odm_user_perms`
    DROP INDEX `user_perms_idx`,
    DROP INDEX `fid`,
    DROP INDEX `uid`,
    DROP INDEX `rights`;
