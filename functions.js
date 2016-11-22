function enforceLength(data_str, max_len)
{
	if(data_str.length>max_len)
	{
		data_str = data_str.substring(0, max_len);
	}
	return data_str;
}

$(function() {
	var $rbId = $('#rb_id');
	var $rbOperacionId = $('#rb_operacion_id');

	$rbId.on('change', function (e) {
		$.ajax({
			url: baseUrl + '/ajax.php',
			data: {
				f: 'rb_operaciones',
				id: $rbId.val(),
			},
			type: 'get',
			dataType: 'json',
			success: function (result) {
				var data = result.data;
				var rows = [];

				for(var i = 0; i < data.length; i++) {
					var d = data[i];
					rows.push(
						'<option value="', d.id ,'">',
							d.orden, ' (', d.taller, ') - ',
							d.descripcion.substring(0, 50),
						'</option>'
					);
				}

				$rbOperacionId.html(rows.join(''));
			}
		});
	});
});
