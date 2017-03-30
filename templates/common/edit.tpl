<script type="text/javascript" src="functions.js"></script>
<script type="text/javascript">

    var rbSelect = '{strip}
        <select class="rb-select" name="rb_id[]">
            <option></option>
            {foreach from=$rbs item=rb}
                <option value="{$rb.id}">
                    {$rb.codigo} - {$rb.detalle}
                </option>
            {/foreach}
        </select>
    {/strip}';

</script>

<form id="addeditform" name="main" class="form-horizontal" action="{$smarty.server.PHP_SELF|escape:'html'}" method="POST" enctype="multipart/form-data" onsubmit="return checksec(); ">
    <input type="hidden" id="db_prefix" value="{$db_prefix}" />

    {assign var='i' value='0'}
    {foreach from=$t_name item=name name='loop1'}
        <input type="hidden" id="secondary{$i|escape}" name="secondary{$i|escape:'html'}" value="" /> <!-- CHM hidden and onsubmit added-->
        <input type="hidden" id="tablename{$i|escape}" name="tablename{$i|escape:'html'}" value="{$name|escape:'html'}" /> <!-- CHM hidden and onsubmit added-->
        {assign var='i' value=$i+1}
    {/foreach}
    <input type="hidden" id="id" name="id" value="{$file_id|escape:'html'}" />
    <input id="i_value" type="hidden" name="i_value" value="{$i|escape:'html'}" /> <!-- CHM hidden and onsubmit added-->

    <div class="control-group">
        <label class="control-label">{$g_lang_label_name}</label>
        <div class="controls read-only">
            <strong>{$realname|escape:'html'}</strong>
        </div>
    </div>

    {if $is_admin == true }
        <div class="control-group">
            <label class="control-label">{$g_lang_editpage_assign_owner}</label>
            <div class="controls">
                <select name="file_owner">
                    {foreach from=$avail_users|smarty:nodefaults item=user}
                        <option value="{$user.id|escape}" {if $pre_selected_owner eq $user.id}selected='selected'{/if}>
                            {$user.last_name|escape:'html'}, {$user.first_name|escape:'html'}
                        </option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">{$g_lang_editpage_assign_department}</label>
            <div class="controls">
                <select name="file_department">
                    {foreach from=$avail_depts|smarty:nodefaults item=dept}
                        <option value="{$dept.id|escape}" {if $pre_selected_department eq $dept.id}selected='selected'{/if}>
                            {$dept.name|escape:'html'}
                        </option>
                        {/foreach}
                </select>
            </div>
        </div>
    {/if}


    <div class="control-group">
        <label class="control-label">
            <a class="body" href="help.html#Add_File_-_Category"  onClick="return popup(this, 'Help')" style="text-decoration:none">
                {$g_lang_category}
            </a>
        </label>
        <div class="controls">
            <select tabindex=2 name="category">
                {foreach from=$cats_array|smarty:nodefaults item=cat}
                    <option value="{$cat.id|escape}" {if $pre_selected_category eq $cat.id}selected='selected'{/if}>
                        {$cat.name|escape:'html'}
                    </option>
                {/foreach}
            </select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">
            <a class="body" href="help.html#Add_File_-_Department" onClick="return popup(this, 'Help')" style="text-decoration:none">
                {$g_lang_addpage_permissions}
            </a>
        </label>
        <div class="controls">
            {include file='../../templates/common/_filePermissions.tpl'}
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">
            <a class="body" href="help.html#Add_File_-_Description" onClick="return popup(this, 'Help')" style="text-decoration:none">
                {$g_lang_label_description}
            </a>
        </label>
        <div class="controls">
            <input tabindex="5" type="Text" name="description" size="50" value="{$description|escape:'html'}"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">
            <a class="body" href="help.html#Add_File_-_Comment" onClick="return popup(this, 'Help')" style="text-decoration:none">
                {$g_lang_label_comment}
            </a>
        </label>
        <div class="controls">
            <textarea tabindex="6" name="comment" rows="4" onchange="this.value=enforceLength(this.value, 255);">{$comment|escape:'html'}</textarea>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">Registro base</label>
        <div class="controls">
            <table class="table" id="rb-table">
                <thead>
                    <tr>
                        <th>Registro</th>
                        <th>Operación</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$file_rbs item=rb}
                        <tr>
                            <input type="hidden" name="rb_id[]" value="{$rb.rb_id}">
                            <input type="hidden" name="rb_operacion_id[]" value="{$rb.rb_operacion_id}">

                            <td>{$rb.codigo} - {$rb.detalle}</td>
                            <td><span class="taller-{$rb.taller|lower}">{$rb.taller|escape:'html'|upper}</span> {$rb.orden} - {$rb.descripcion}</td>
                            <td style="text-align:center;">
                				<a href="#" class="rb-delete-row" title="Eliminar fila">
                					<i class="icon-remove"></i>
                				</a>
                			</td>
                        </tr>
                    {/foreach}
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3">
                            <button type="button" class="btn" id="rb-add-row">
                                <i class="icon-plus"></i> Agregar
                            </button>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
