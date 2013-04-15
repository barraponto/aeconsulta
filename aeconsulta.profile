<?php

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function aeconsulta_form_install_configure_form_alter(&$form, $form_state) {
  // Call the hook_form_alter from l10n_install profile.
  require_once(DRUPAL_ROOT . '/profiles/l10n_install/l10n_install.profile');
  l10n_install_form_install_configure_form_alter($form, $form_state);
}

/**
 * Implements hook_install_tasks()
 */
function aeconsulta_install_tasks(&$install_state) {
  $tasks = array();

  // Add the Panopoly app selection to the installation process.
  require_once(drupal_get_path('module', 'apps') . '/apps.profile.inc');
  $tasks = $tasks + apps_profile_install_tasks($install_state, array('machine name' => 'panopoly', 'default apps' => array()));

  // Add Localization tasks to the installation process.
  require_once(DRUPAL_ROOT . '/profiles/l10n_install/l10n_install.profile');
  $tasks = $tasks + l10n_install_install_tasks($install_state);

  return $tasks;
}

/**
 * Implements hook_install_tasks_alter()
 */
function aeconsulta_install_tasks_alter(&$tasks, $install_state) {
  // Remove core steps for translation imports.
  require_once(DRUPAL_ROOT . '/profiles/l10n_install/l10n_install.profile');
  l10n_install_install_tasks_alter($tasks, $install_state);

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
 * Implements hook_form_alter().
 */
function aeconsulta_form_ae_consultation_node_form_alter(&$form, &$form_state) {
  if (user_access('edit site frontpage from node form')) {
    // If this is a new node, $nid should be NULL.
    $nid = $form['nid']['#value'];
    $path = $nid ? 'node/' . $nid : $nid;

    $form['menu']['frontpage'] = array(
      '#type' => 'checkbox',
      '#title' => t('Make this the front page.'),
      '#default_value' => (drupal_get_normal_path(variable_get('site_frontpage', FALSE)) === $path)
    );
  }
}

/**
 * Helper function for aeconsulta_node_insert and aeconsulta_node_update.
 */
function _aeconsulta_node_frontpage($node) {
  if ($node->type == 'ae_consultation' && !empty($node->menu['frontpage']) && user_access('edit site frontpage from node form')) {
    variable_set('site_frontpage', 'node/' . $node->nid);
    unset($node->menu['frontpage']);
  }
}

/**
 * Implements hook_node_insert().
 */
function aeconsulta_node_insert($node) {
  _aeconsulta_node_frontpage($node);
}

/**
 * Implements hook_node_update().
 */
function aeconsulta_node_update($node) {
  _aeconsulta_node_frontpage($node);
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

/**
 * Implements hook_permission().
 */
function aeconsulta_permission() {
  return array(
    'edit site frontpage from node form' =>  array(
      'title' => t('Set node as frontpage'),
      'description' => t('Set a node as frontpage from the node edit form.'),
    ),
  );
}

/**
 * Implements hook_field_widget_WIDGET_TYPE_form_alter().
 */
function aeconsulta_field_widget_addressfield_standard_form_alter(&$element, &$form_state, $context) {
  if ($context['field']['field_name'] == 'field_whereabouts') {
    $element['street_block']['#access'] = FALSE;
    $element['locality_block']['postal_code']['#access'] = FALSE;
    $element['locality_block']['dependent_locality']['#access'] = FALSE;
  }
}
