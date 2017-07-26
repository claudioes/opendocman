<?php
require_once('../config.php');

// PDO

$dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8";
$pdo = new PDO($dsn, DB_USER, DB_PASS);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// Configuración

$sth = $pdo->prepare("
    SELECT value
    FROM {$GLOBALS['CONFIG']['db_prefix']}settings
    WHERE name = 'dataDir'
    LIMIT 1
");
$sth->execute();
$dataDir = $sth->fetchColumn();

// Documentos a ser exportados

$sth = $pdo->prepare("
    SELECT *
    FROM {$GLOBALS['CONFIG']['db_prefix']}export_rp
");
$sth->execute();
$jobs = $sth->fetchAll(\PDO::FETCH_ASSOC);

// Empiezo a exportar

$okFiles = [];

foreach($jobs as $job) {
    // Documento de ODM
    $file = $dataDir . $job['data_id'] . '.dat';

    // Existe el archivo?

    if (file_exists($file)) {
        $destination = MAZDEN_DOC_FOLDER . str_replace('\\', '/', $job['destination']);
        $destinationFolder = dirname($destination);

        // Trato de copiarlo

        try {
            // Existe la carpeta de destino? La creo si no

            if (!is_dir($destinationFolder)) {
                mkdir($destinationFolder, 0777, true);
            }

            // Copio el archivo

            copy($file, $destination);
            $okFiles[] = $job['id'];
            echo 'JOB ID ' . $job['id'] . ' >> OK<br>';
        } catch (\Exception $e) {
            echo 'JOB ID ' . $job['id'] . ' >> Error: ' . $e->getMessage() . '<br>';
        }
    }
}

if (count($okFiles)) {
    $pdo->exec("DELETE FROM {$GLOBALS['CONFIG']['db_prefix']}export_rp WHERE id IN (" . join(',', $okFiles) . ")");
    echo "<strong>DOCUMENTOS EXPORTADOS</strong>";
}

echo "<strong>FINALIZADO</strong>";
