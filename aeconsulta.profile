<?php

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function aeconsulta_form_install_configure_form_alter(&$form, $form_state) {

}

/**
 * Implements hook_install_tasks()
 */
function aeconsulta_install_tasks(&$install_state) {
  $tasks = array();

  // Add the Panopoly app selection to the installation process
  require_once(drupal_get_path('module', 'apps') . '/apps.profile.inc');
  $tasks = $tasks + apps_profile_install_tasks($install_state, array('machine name' => 'panopoly', 'default apps' => array()));

  return $tasks;
}

/**
 * Implements hook_install_tasks_alter()
 */
function aeconsulta_install_tasks_alter(&$tasks, $install_state) {
  // Magically go one level deeper in solving years of dependency problems
  require_once(drupal_get_path('module', 'panopoly_core') . '/panopoly_core.profile.inc');
  $tasks['install_load_profile']['function'] = 'panopoly_core_install_load_profile';
}

/**
 * Implements hook_init().
 */
function aeconsulta_init() {
  if (!variable_get('aeconsulta_has_editors', FALSE)) {
    global $user;
    if (($user->uid == 1) && (variable_get('install_task', 'done') == 'done') &! (implode('/', arg()) == 'admin/people/create')) {
        drupal_set_message(
          t('To complete the installation, please <a href="@user-add">add an Editor user to your site</a>.',
            array('@user-add' => url('admin/people/create'))), 'info');
    }
  }
}

/**
 * Implements hook_form_FORM_ID_alter().
 */
function aeconsulta_form_user_register_form_alter(&$form, &$form_state) {
  if (!variable_get('aeconsulta_has_editors', FALSE)) {
    global $user;
    if (($user->uid == 1) && (variable_get('install_task', 'done') == 'done')) {
      // @TODO: Use a js-based tutorial to guide this step.
      drupal_set_message(t('Add a user with the Editor role, then log out and log in as that user.'), 'info');
    }
  }
}

/**
 * Implements hook_user_insert().
 */
function aeconsulta_user_insert(&$edit, $account, $category) {
  if (!variable_get('aeconsulta_has_editors', FALSE)) {
    $editor = user_role_load_by_name('Editor');
    // If an Editor user has been created, stop nagging the administrator.
    if (in_array($editor->rid, $account->roles)) {
      variable_set('aeconsulta_has_editors', TRUE);
      drupal_set_message(t('Now <a href="@user-logout">log out</a> and come back as @user-name!',
        array('@user-logout' => url('user/logout'), '@user-name' => $account->name)), 'info');
    }
  }
}
