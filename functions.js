function enforceLength(data_str, max_len)
{
	if(data_str.length>max_len)
	{
		data_str = data_str.substring(0, max_len);
	}
	return data_str;
}

$(function() {
	var $rbAddRow = $('#rb-add-row');
	var $rbTable = $('#rb-table');

	$rbAddRow.click(function (e) {
		var $row = $('<tr>').append([
			'<td>', rbSelect ,'</td>',
			'<td><select class="rb-operacion-select" name="rb_operacion_id[]"><select></td>',
			'<td style="text-align:center;">',
				'<a href="#" class="rb-delete-row" title="Eliminar fila">',
					'<i class="icon-remove"></i>',
				'</a>',
			'</td>',
		].join(''));

		$rbTable.find('tbody').append($row);
	});

	$rbTable.on('click', 'a.rb-delete-row', function (e) {
		e.preventDefault();
		$(this).closest('tr').remove();
	});

	$rbTable.on('change', 'select.rb-select', function (e) {
		var rbId = this.value;
		var $row = $(this).closest('tr');
		var $rbOperaciones = $row.find('select.rb-operacion-select');

		$.ajax({
			url: baseUrl + '/ajax.php',
			data: {
				f: 'rb_operaciones',
				id: rbId,
			},
			type: 'get',
			dataType: 'json',
			success: function (result) {
				var operaciones = result.data;
				var options = [];

				for(var i = 0; i < operaciones.length; i++) {
					var operacion = operaciones[i];
					options.push(
						'<option value="', operacion.id ,'">',
							operacion.orden, ' (', operacion.taller, ') - ',
							operacion.descripcion.substring(0, 50),
						'</option>'
					);
				}

				$rbOperaciones.html(options.join(''));
			}
		});
	});
});
