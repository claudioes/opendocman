<?php
use Aura\Html\Escaper as e;

/*
search.php - main search logic
Copyright (C) 2002-2007 Stephen Lawrence Jr., Khoa Nguyen, Jon Miner
Copyright (C) 2008-2013 Stephen Lawrence Jr.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

session_start();

include('odm-load.php');

if (!isset($_SESSION['uid'])) {
    redirect_visitor();
}

include('udf_functions.php');

$last_message = (isset($_REQUEST['last_message']) ? $_REQUEST['last_message'] : '');

/*$_GET['where']='department';
  $_GET['keyword']='Information Systems';
  $_SESSION['uid']=102;
  $_GET['submit']='submit';
  $_GET['exact_phrase']='on';
  $_GET['case_sensitivity']='';
*/
/// includes
$start_time = time();
draw_header(msg('search'), $last_message);

$search_author = filter_input(INPUT_GET, 'search_author');
$search_category = filter_input(INPUT_GET, 'search_category');
$search_department = filter_input(INPUT_GET, 'search_department');
$search_descriptions = filter_input(INPUT_GET, 'search_descriptions');
$search_realname = filter_input(INPUT_GET, 'search_realname');
$search_comments = filter_input(INPUT_GET, 'search_comments');
$search_file_id = filter_input(INPUT_GET, 'search_file_id');
$search_rb_id = filter_input(INPUT_GET, 'search_rb_id');
$author_locked_files = filter_input(INPUT_GET, 'author_locked_files');
$search_exact_phrase = isset($_GET['search_exact_phrase']);
?>

<body bgcolor="white">
<br>

<div class="accordion" id="accordion-master">
    <div class="accordion-group">

        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-master" href="#accordion-search">
                <?php echo msg('search') ?>
            </a>
        </div>

        <div id="accordion-search" class="accordion-body collapse <?php echo isset($_GET['submit']) ? '' : 'in' ?>" >
            <div class="accordion-inner">
                <form>
                    <table border="0" cellspacing="5" cellpadding="5">
                        <tbody>
                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('author') ?></b>
                                </td>
                                <td>
                                    <select name="search_author">
                                        <option value=""></option>
                                        <?php $sth = $pdo->prepare("SELECT id, CONCAT(first_name, ' ', last_name) AS name FROM {$GLOBALS['CONFIG']['db_prefix']}user ORDER BY name") ?>
                                        <?php $sth->execute() ?>
                                        <?php foreach($sth->fetchAll() as $row): ?>
                                            <option value="<?php echo $row[0] ?>" <?php echo ($row[0] == $search_author ? 'selected': '') ?>><?php echo $row[1] ?></option>
                                        <?php endforeach ?>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('department') ?></b>
                                </td>
                                <td>
                                    <select name="search_department">
                                        <option value=""></option>
                                        <?php $sth = $pdo->prepare("SELECT id, name FROM {$GLOBALS['CONFIG']['db_prefix']}department ORDER BY name") ?>
                                        <?php $sth->execute() ?>
                                        <?php foreach($sth->fetchAll() as $row): ?>
                                            <option value="<?php echo $row[0] ?>" <?php echo ($row[0] == $search_department ? 'selected': '') ?>><?php echo $row[1] ?></option>
                                        <?php endforeach ?>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('category') ?></b>
                                </td>
                                <td>
                                    <select name="search_category">
                                        <option value=""></option>
                                        <?php $sth = $pdo->prepare("SELECT id, name FROM {$GLOBALS['CONFIG']['db_prefix']}category ORDER BY name") ?>
                                        <?php $sth->execute() ?>
                                        <?php foreach($sth->fetchAll() as $row): ?>
                                            <option value="<?php echo $row[0] ?>" <?php echo ($row[0] == $search_category ? 'selected': '') ?>><?php echo $row[1] ?></option>
                                        <?php endforeach ?>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('label_description') ?></b>
                                </td>
                                <td>
                                    <input type="text" name="search_descriptions" value="<?php echo $search_descriptions ?>">
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('label_filename') ?></b>
                                </td>
                                <td>
                                    <input type="text" name="search_realname" value="<?php echo $search_realname ?>">
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('label_comment') ?></b>
                                </td>
                                <td>
                                    <input type="text" name="search_comments" value="<?php echo $search_comments ?>">
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b><?php echo msg('file') ?> #</b>
                                </td>
                                <td>
                                    <input type="text" name="search_file_id" value="<?php echo $search_file_id ?>">
                                </td>
                            </tr>

                            <tr>
                                <td valign="top">
                                    <b>RB Nº</b>
                                </td>
                                <td>
                                    <input type="text" name="search_rb_id" value="<?php echo $search_rb_id ?>">
                                </td>
                            </tr>

                            <?php udf_functions_search_options() ?>

                            <tr>
								<td></td>
                                <td>
									<label class="checkbox">
										<input type="checkbox" style="margin-top:0;" name="search_exact_phrase" <?php echo $search_exact_phrase ? 'checked' : '' ?>> <?php echo msg('label_exact_phrase') ?>
									</label>

                                    <br>

									<button class="btn" type="submit" name="submit">
										<?php echo msg('search'); ?>
									</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<?php
    if (isset($_GET['submit'])) {
        $where = [];
        $params = [];

        if ($search_author) {
            $where[] = "d.owner = :author";
            $params['author'] = $search_author;
        }

        if ($search_category) {
            $where[] = "d.category = :category";
            $params['category'] = $search_category;
        }

        if ($search_department) {
            $where[] = "d.department = :department";
            $params['department'] = $search_department;
        }

        if ($search_descriptions) {
            $where[] = "d.description LIKE :description";

			if (!$search_exact_phrase) {
				$search_descriptions = "%$search_descriptions%";
			}

            $params['description'] = $search_descriptions;
        }

        if ($search_realname) {
            $where[] = "d.realname LIKE :realname";

			if (!$search_exact_phrase) {
				$search_realname = "%$search_realname%";
			}

            $params['realname'] = $search_realname;
        }

        if ($search_comments) {
            $where[] = "d.comment LIKE :comment";

			if (!$search_exact_phrase) {
				$search_comments = "%$search_comments%";
			}

            $params['comment'] = $search_comments;
        }

        if ($search_file_id) {
            $where[] = "d.id = :id";
            $params['id'] = $search_file_id;
        }

        if ($search_rb_id) {
            $where[] = "EXISTS (SELECT 1 FROM {$GLOBALS['CONFIG']['db_prefix']}data_rb WHERE {$GLOBALS['CONFIG']['db_prefix']}data_rb.rb_id = :rb_id AND {$GLOBALS['CONFIG']['db_prefix']}data_rb.data_id = d.id)";
            $params['rb_id'] = $search_rb_id;
        }

        if ($author_locked_files) {
            $where[] = "d.status = :status AND d.owner = :uid ";
            $params['status'] = $author_locked_files;
            $params['uid'] = $_SESSION['uid'];
        }

        //$udf_array = array_filter($_GET, function ($value) {
        //    return false !== strpos($value, 'udftbl_');
        //}, ARRAY_FILTER_USE_KEY);

		$udf_array = [];
		foreach($_GET as $key => $value) {
			if (strpos($key, 'udftbl_')) {
				$udf_array[$key] = $value;
			}
		}

        foreach($udf_array as $key => $value) {
            if($value) {
                if (is_array($value)) {
                    $where[] = "EXISTS (SELECT 1 FROM {$key}_data WHERE {$key}_data.udf_id in (" . join(', ', $value) . ") AND {$key}_data.data_id = d.id)";
                } else {
                    $where[] = "$key = :{$key}";
                    $params[$key] = $value;
                }
            }
        }

        $query = "SELECT d.id FROM {$GLOBALS['CONFIG']['db_prefix']}data as d";

        if (count($where)) {
            $query .= ' WHERE ' . join(' AND ', $where);
        }

        if (isset($_GET['sort_by']) && $_GET['sort_by']) {
            $query .= " ORDER BY $_GET[sort_by] $_GET[sort_order]";
        } else {
            $query .= ' ORDER BY d.id ASC';
        }

        //die($query);

        $stmt = $pdo->prepare($query);
        $stmt->execute($params);
        $result = $stmt->fetchAll();

        $index = 0;
        $id_array = array();

        foreach ($result as $row) {
            $id_array[$index++] = $row['id'];
            $index++;
        }

        $current_user = new User($_SESSION['uid'], $pdo);
        $user_perms = new User_Perms($_SESSION['uid'], $pdo);
        $current_user_permission = new UserPermission($_SESSION['uid'], $pdo);

        if (isset($_GET['where']) && $_GET['where'] == 'author_locked_files') {
            $view_able_files_id = $current_user->getExpiredFileIds();
        } else {
            $view_able_files_id = $current_user_permission->getViewableFileIds(false);
        }

        $search_result = array_values(array_intersect($id_array, $view_able_files_id));

        callPluginMethod('onSearch');

        list_files($search_result, $current_user_permission, $GLOBALS['CONFIG']['dataDir'], false, false);
    }
?>

<?php draw_footer() ?>
