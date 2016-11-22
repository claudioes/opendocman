<div class="accordion" id="accordion-file-permissions">
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-file-permissions" href="#collapse-department">
                {$g_lang_filepermissionspage_edit_department_permissions}
            </a>
        </div>
        <div id="collapse-department" class="accordion-body collapse">
            <table id="department_permissions_table">
                <thead>
                    <tr>
                        <td>Department</td>
                        <td>Forbidden</td>
                        <td>None</td>
                        <td>View</td>
                        <td>Read</td>
                        <td>Write</td>
                        <td>Admin</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$avail_depts item=dept}
                        {if $dept.selected eq 'selected'}
                            {assign var="selected" value="checked='checked'"}
                        {else}
                            {assign var="noneselected" value="checked='checked'"}
                        {/if}
                        <tr>
                            <td>{$dept.name|escape:'html'}</td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="-1" {if $dept.rights eq '-1'}checked="checked"{/if} /></td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="0" {if $dept.rights eq '0'}checked="checked"{/if} {$noneselected}/></td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="1" {if $dept.rights eq 1}checked="checked"{/if} {$selected} /></td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="2" {if $dept.rights eq 2}checked="checked"{/if} /></td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="3" {if $dept.rights eq 3}checked="checked"{/if} /></td>
                            <td><input type="radio" name="department_permission[{$dept.id}]" value="4" {if $dept.rights eq 4}checked="checked"{/if} /></td>
                        </tr>
                        {assign var="selected" value=""}
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-file-permissions" href="#collapse-user">
                {$g_lang_filepermissionspage_edit_user_permissions}
            </a>
        </div>
        <div id="collapse-user" class="accordion-body collapse">
            <table id="user_permissions_table">
                <thead>
                    <tr>
                        <td>User</td>
                        <td>Forbidden</td>
                        <td>View</td>
                        <td>Read</td>
                        <td>Write</td>
                        <td>Admin</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$avail_users item=user}
                        {if $user.rights eq ''}
                            {assign var="selected" value="checked='checked'"}
                        {/if}

                        <tr>
                            <td>{$user.last_name|escape:'html'}, {$user.first_name|escape:'html'}</td>
                            <td><input type="radio" name="user_permission[{$user.id}]" value="-1" {if $user.rights eq '-1'}checked="checked"{/if} /></td>
                            <td><input type="radio" name="user_permission[{$user.id}]" value="1" {if $user.rights eq 1}checked="checked"{/if} /></td>
                            <td><input type="radio" name="user_permission[{$user.id}]" value="2" {if $user.rights eq 2}checked="checked"{/if} /></td>
                            <td><input type="radio" name="user_permission[{$user.id}]" value="3" {if $user.rights eq 3}checked="checked"{/if} /></td>
                            <td><input type="radio" name="user_permission[{$user.id}]" value="4" {if $user.rights eq 4 || ($user.id eq $user_id && $user.rights eq '') }checked="checked"{/if} /></td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>

{literal}
    <script>
        $(function() {
            var $department_permissions_table = $('#department_permissions_table');
            var $user_permissions_table = $('#user_permissions_table');

            if ($department_permissions_table && $department_permissions_table.length > 0) {
               var oTable1 = $department_permissions_table.dataTable({
                    "sScrollY": "300px",
                    "bPaginate": false,
                    "bAutoWidth": true,
                    "oLanguage": {
                        "sUrl": "includes/language/DataTables/datatables." + langLanguage + ".txt"
                    }
                });
            }

            if ($user_permissions_table && $user_permissions_table.length > 0) {
               var oTable2 = $user_permissions_table.dataTable({
                    "sScrollY": "300px",
                    "bPaginate": false,
                    "bAutoWidth": true,
                    "oLanguage": {
                        "sUrl": "includes/language/DataTables/datatables." + langLanguage + ".txt"
                    }
                });
            }
        });
    </script>
{/literal}
