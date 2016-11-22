<h3 class="text-center">
    {if $file_detail.file_unlocked }
        <img src="images/file_unlocked.png" alt="" border="0" align="absmiddle">
    {else}
        <img src="images/file_locked.png" alt="" border="0" align="absmiddle">
    {/if}

    {$file_detail.realname|escape:'html'}
</h3>

<form name="data">
    <input type="hidden" name="to" value="{$file_detail.to_value|escape:'html'}" />
    <input type="hidden" name="subject" value="{$file_detail.subject_value|escape:'html'}" />
    <input type="hidden" name="comments" value="{$file_detail.comments_value|escape:'html'}" />
</form>

<table class="simple-table">
    <tr>
        <td class="title">{$g_lang_category}:</td>
        <td>{$file_detail.category|escape:'html'}</td>
    </tr>

    {$file_detail.udf_details_display}

    <tr>
        <td class="title">{$g_lang_label_size}:</td>
        <td>{$file_detail.filesize|escape:'html'}</td>
    </tr>
    <tr>
        <td class="title">{$g_lang_label_created_date}:</td>
        <td>{$file_detail.created|escape:'html'}</td>
    </tr>
    <tr>
        <td class="title">{$g_lang_owner}:</td>
        <td>
            <a href="mailto:{$file_detail.owner_email|escape:'html'}?Subject=Regarding%20your%20document:{$file_detail.realname|escape:'html'}&Body=Hello%20{$file_detail.owner_fullname|escape:'html'}"> {$file_detail.owner|escape:'html'}</a>
        </td>
    </tr>
    <tr>
        <td class="title">{$g_lang_label_description}:</td>
        <td>{$file_detail.description|escape:'html'}</td>
    </tr>
    <tr>
    	<td class="title">{$g_lang_label_comment}:</td>
        <td>{$file_detail.comment|escape:'html'}</td>
    </tr>
    <tr>
        <td class="title">{$g_lang_revision}:</td>
        <td>
            <div id="details_revision">{$file_detail.revision|escape:'html'}</div>
        </td>
    </tr>
    <tr>
        <td class="title">Registro base Nº:</td>
        <td>{$file_detail.rb nofilter}</td>
    </tr>
    <tr>
        <td class="title">Operación Nº:</td>
        <td>{$file_detail.rb_operacion nofilter}</td>
    </tr>
    {if $file_detail.file_under_review}
        <tr>
            <td class="title">{$g_lang_label_reviewer}:</td>
            <td>{$file_detail.reviewer|escape:'html'} (<a href='javascript:showMessage()'>{$g_lang_message_reviewers_comments_re_rejection}</a>)</td>
        </tr>
    {/if}

    {if $file_detail.status gt 0}
        <tr>
            <td class="title">{$g_lang_detailspage_file_checked_out_to}:</td>
            <td><a href="mailto:{$checkout_person_email|escape:'html'}?Subject=Regarding%20your%20checked-out%20document:{$file_detail.realname|escape:'html'}&Body=Hello%20{$checkout_person_full_name.$fullname[0]|escape:'html'}"> {$checkout_person_full_name[1]|escape:'html'}, {$checkout_person_full_name[0]|escape:'html'}</a></td>
        </tr>
    {/if}
</table>

<div class="row text-center">
    <div class="span12">
        {if $view_link ne ''}
            <a href="{$view_link|escape}" class="positive">
                <img src="images/view.png" alt="view"/>
                {$g_lang_detailspage_view}
            </a>
        {/if}
        {if $check_out_link ne ''}
            <a href="{$check_out_link|escape}" class="regular">
                <img src="images/check-out.png" alt="check out"/>
                {$g_lang_detailspage_check_out}
            </a>
        {/if}
        {if $edit_link ne ''}
            <a href="{$edit_link|escape}" class="regular">
                <img src="images/edit.png" alt="edit"/>
                {$g_lang_detailspage_edit}
            </a>
            <a href="javascript:my_delete()" class="negative">
                <img src="images/delete.png" alt="delete"/>
                {$g_lang_detailspage_delete}
            </a>
        {/if}
        <a href="{$history_link|escape}" class="regular">
            <img src="images/history.png" alt="history"/>
            {$g_lang_detailspage_history}
        </a>
    </div>
</div>

{literal}
    <script type="text/javascript">
        var message_window;
        var mesg_window_frm;
        function my_delete() {
            if(window.confirm("{/literal}{$g_lang_detailspage_are_sure}{literal}")) {
                window.location = "{/literal}{$my_delete_link}{literal}";
            }
        }

        function sendFields() {
            mesg_window_frm = message_window.document.author_note_form;
            if(mesg_window_frm) {
                mesg_window_frm.to.value = document.data.to.value;
                mesg_window_frm.subject.value = document.data.subject.value;
                mesg_window_frm.comments.value = document.data.comments.value;
            }
    	}

    	function showMessage() {
            message_window = window.open('{/literal}{$comments_link|escape}{literal}' , 'comment_wins', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=450,height=200');
            message_window.focus();
            setTimeout("sendFields();", 500);
        }
    </script>
{/literal}
