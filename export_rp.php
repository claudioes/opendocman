<?php
require_once('config.php');

$dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8";
try {
    $pdo = new PDO($dsn, DB_USER, DB_PASS);
} catch (PDOException $e) {
    die($e->getMessage());
}
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// Configuración
$sth = $pdo->prepare("
    SELECT value
    FROM {$GLOBALS['CONFIG']['db_prefix']}settings
    WHERE name = 'dataDir'
");
$sth->execute();
$settings = $sth->fetch(\PDO::FETCH_ASSOC);
$dataDir = $settings['value'];

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
    $file = str_replace('/', '\\', $dataDir) . $job['data_id'] . '.dat';

    // Existe el archivo?
    if (file_exists($file)) {
        $destination = MAZDEN_DOC_FOLDER . $job['destination'];
        $destinationFolder = dirname($destination);

        // Trato de copiarlo
        try {
            // Existe la carpeta de destino?
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
