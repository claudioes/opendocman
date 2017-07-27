<?php
require_once('../config.php');

$dbPrefix = $GLOBALS['CONFIG']['db_prefix'];

$pdo = new PDO("mysql:host=". DB_HOST .";dbname=". DB_NAME ."",
    DB_USER,
    DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
    ]
);

$sourceFolder = $pdo->query("
    SELECT value
    FROM {$dbPrefix}settings
    WHERE name = 'dataDir'
    LIMIT 1
")->fetchColumn();

$jobs = $pdo->query("
    SELECT *
    FROM {$dbPrefix}export_rp
")->fetchAll(\PDO::FETCH_ASSOC);

echo "<h1>Exportación de documentos de ODM a Mazden</h1>";

if (!count($jobs)) {
    echo "<h3>Nada para exportar</h3>";
    die();
}

$copiedFiles = [];

foreach($jobs as $job) {
    $sourceFile = "$sourceFolder/{$job['data_id']}.dat";

    if (file_exists($sourceFile)) {
        $destinationFile = MAZDEN_DOC_FOLDER . '/' . str_replace('\\', '/', $job['destination']);
        $destinationFolder = dirname($destinationFile);

        if (!is_dir($destinationFolder) && !mkdir($destinationFolder, 0777, true)) {
            echo "<p style=\"color: red;\">JOB ID {$job['id']} >> ERROR: No se pudo crear la carpeta '{$destinationFolder}'</p>";
        } else {
            if (copy($sourceFile, $destinationFile)) {
                echo "<p>JOB ID {$job['id']} >> <span style=\"color: green; font-weight: bold;\">OK</span></p>";
                $copiedFiles[] = $job['id'];
            } else {
                echo "<p style=\"color: red;\">JOB ID {$job['id']} >> ERROR: No se pudo copiar el archivo '{$destinationFile}'</p>";
            }
        }
    } else {
        echo "<p style=\"color: red;\">JOB ID {$job['id']} >> ERROR: No existe el archivo '{$sourceFile}'</p>";
    }
}

if (count($copiedFiles)) {
    $pdo->exec("
        DELETE FROM
        {$dbPrefix}export_rp
        WHERE id IN (" . join(',', $copiedFiles) . ")"
    );

    echo "<h4>". count($copiedFiles) ." documentos exportados</h4>";
}

echo "<h3>Finalizado!</h3>";
