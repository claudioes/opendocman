<script type="text/javascript" src="functions.js"></script>
<!-- file upload formu using ENCTYPE -->
<form id="addeditform" name="main" class="form-horizontal" action="add.php" method="POST" enctype="multipart/form-data" onsubmit="return checksec();">
    <input type="hidden" id="db_prefix" value="{$db_prefix|escape:'html'}" />

    {assign var='i' value='0'}
    {foreach from=$t_name item=name name='loop1'}
        <input type="hidden" id="secondary{$i|escape:'html'}" name="secondary{$i|escape:'html'}" value="" /> <!-- CHM hidden and onsubmit added-->
        <input type="hidden" id="tablename{$i|escape:'html'}" name="tablename{$i|escape:'html'}" value="{$name|escape:'html'}" /> <!-- CHM hidden and onsubmit added-->
        {assign var='i' value=$i+1}
    {/foreach}

    <input id="i_value" type="hidden" name="i_value" value="{$i|escape:'html'}" /> <!-- CHM hidden and onsubmit added-->

    <div class="control-group">
        <a href="help.html#Add_File_-_File_Location" target="_blank">
            <label class="control-label">{$g_lang_label_file_location}</label>
        </a>
        <div class="controls">
            <input tabindex="0" name="file[]" type="file" multiple="multiple">
        </div>
    </div>

    {if $is_admin == true }
        <div class="control-group">
            <label class="control-label">{$g_lang_editpage_assign_owner}</label>
            <div class="controls">
                <select name="file_owner">
                    {foreach from=$avail_users item=user}
                        <option value="{$user.id}" {$user.selected}>{$user.last_name|escape:'html'}, {$user.first_name|escape:'html'}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">{$g_lang_editpage_assign_department}</label>
            <div class="controls">
                <select name="file_department">
                    {foreach from=$avail_depts item=dept}
                        <option value="{$dept.id}" {$dept.selected}>{$dept.name|escape:'html'}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {/if}

    <div class="control-group">
        <a href="help.html#Add_File_-_Category" target="_blank">
            <label class="control-label">{$g_lang_category}</label>
        </a>
        <div class="controls">
            <select tabindex=2 name="category" >
                {foreach from=$cats_array item=cat}
                    <option value="{$cat.id}">{$cat.name|escape:'html'}</option>
                {/foreach}
            </select>
        </div>
    </div>

    <div class="control-group">
        <a href="help.html#Add_File_-_Department" target="_blank">
            <label class="control-label">{$g_lang_addpage_permissions}</label>
        </a>
        <div class="controls">
            {include file='../../templates/common/_filePermissions.tpl'}
        </div>
    </div>

    <div class="control-group">
        <a href="help.html#Add_File_-_Description" target="_blank">
            <label class="control-label">{$g_lang_label_description}</label>
        </a>
        <div class="controls">
            <input tabindex="5" type="Text" name="description" size="50">
        </div>
    </div>

    <div class="control-group">
        <a href="help.html#Add_File_-_Comment" target="_blank">
            <label class="control-label">{$g_lang_label_comment}</label>
        </a>
        <div class="controls">
            <textarea tabindex="6" name="comment" rows="4" onchange="this.value=enforceLength(this.value, 255);"></textarea>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">Registro base Nº</label>
        <div class="controls">
            <select id="rb_id" name="rb_id" style="width:100%;">
                <option value="" selected></option>
                {foreach from=$rbs item=rb}
                    <option value="{$rb.id}">{$rb.codigo|escape:'html'} - {$rb.detalle|escape:'html'}</option>
                {/foreach}
            </select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">Operación Nº</label>
        <div class="controls">
            <select id="rb_operacion_id" name="rb_operacion_id" style="width:100%;"></select>
        </div>
    </div>
