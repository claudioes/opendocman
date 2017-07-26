CREATE TABLE `odm_data_rb` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `data_id` INT(10) UNSIGNED NOT NULL,
    `rb_id` INT(10) UNSIGNED NOT NULL,
    `rb_operacion_id` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `data_id_rb_id_rb_operacion_id` (`data_id`, `rb_id`, `rb_operacion_id`)
)ENGINE=MyISAM;

INSERT INTO odm_data_rb(data_id, rb_id, rb_operacion_id)
SELECT id, rb_id, rb_operacion_id FROM odm_data WHERE rb_id IS NOT NULL;

ALTER TABLE `odm_data`
    DROP COLUMN `rb_id`,
    DROP COLUMN `rb_operacion_id`;
