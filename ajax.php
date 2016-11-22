<?php
session_start();

include('odm-load.php');

// Compruebo que el usuario esté logueado
if (!isset($_SESSION['uid'])) {
    redirect_visitor();
}

// Solo se acepta método GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['f'])) {
        $func = filter_var($_GET['f'], FILTER_SANITIZE_STRING);
        ajax_function($func, $pdo);
    } else {
        echo 'Ajax error: no function set';
    }
} else {
    echo 'Ajax error: only get allowed';
}

// Redirige a la función correspondiente
function ajax_function($func, $pdo) {
    switch ($func) {
        case 'rb_operaciones':
            ajax_rb_operaciones($pdo, (int)$_GET['id']);
            break;
    }
}

// Devuelve las operaciones de un registro base
function ajax_rb_operaciones($pdo, $rb_id) {
    // Operaciones
    $sth = $pdo->prepare('
        SELECT o.id, o.taller, o.orden, o.descripcion
        FROM ' . MAZDEN_DB_NAME . '.rb_operaciones o
        JOIN ' . MAZDEN_DB_NAME . '.rb r ON o.idrb IN (r.id, r.idrb_origen)
        WHERE r.id=?
        ORDER BY o.taller, o.orden
    ');
    $sth->execute([$rb_id]);
    $operaciones = $sth->fetchAll(\PDO::FETCH_ASSOC);

    ajax_return(['data' => $operaciones]);
}

// Imprime el resultado en JSON para ser leido en el cliente
function ajax_return($data) {
    header('Content-Type: application/json');
    echo json_encode($data);
}
