core = 7.x
api = 2

projects[kw_manifests][type] = "module"
projects[kw_manifests][download][type] = "git"
projects[kw_manifests][download][url] = "git://github.com/kraftwagen/kw-manifests.git"
projects[kw_manifests][subdir] = "kraftwagen"

projects[kw_itemnames][type] = "module"
projects[kw_itemnames][download][type] = "git"
projects[kw_itemnames][download][url] = "git://github.com/kraftwagen/kw-itemnames.git"
projects[kw_itemnames][subdir] = "kraftwagen"

; The Panopoly Foundation
projects[panopoly_core][version] = 1.0-rc3
projects[panopoly_core][subdir] = panopoly
projects[panopoly_core][patch][field_group_kalatheme] = https://raw.github.com/barraponto/aeconsulta/2d1ac3fa2f83fc7a2a72e99cf8d6289d196af7e8/patches/field_group-fix_colspan_looks_in_kalatheme.patch

projects[panopoly_images][version] = 1.0-rc3
projects[panopoly_images][subdir] = panopoly

projects[panopoly_theme][version] = 1.0-rc3
projects[panopoly_theme][subdir] = panopoly

projects[panopoly_magic][version] = 1.0-rc3
projects[panopoly_magic][subdir] = panopoly

projects[panopoly_widgets][version] = 1.0-rc3
projects[panopoly_widgets][subdir] = panopoly

projects[panopoly_admin][version] = 1.0-rc3
projects[panopoly_admin][subdir] = panopoly
projects[panopoly_admin][patch][1963968] = http://drupal.org/files/panopoly_admin-undefined_index_in_hook_menu_link_alter.patch

projects[panopoly_users][version] = 1.0-rc3
projects[panopoly_users][subdir] = panopoly

; The Panopoly Toolset

projects[panopoly_pages][version] = 1.0-rc3
projects[panopoly_pages][subdir] = panopoly

projects[panopoly_wysiwyg][version] = 1.0-rc3
projects[panopoly_wysiwyg][subdir] = panopoly

projects[panopoly_search][version] = 1.0-rc3
projects[panopoly_search][subdir] = panopoly

; Panopoly Recommended

projects[devel][version] = 1.3
projects[devel][subdir] = contrib

projects[uuid][version] = 1.x-dev
projects[uuid][subdir] = contrib
projects[uuid][download][type] = git
projects[uuid][download][revision] = 4730c67
projects[uuid][download][branch] = 7.x-1.x
projects[uuid][patch][1605284] = http://drupal.org/files/1605284-define-types-for-tokens-6.patch

; The Panopoly Kalatheme
projects[kalatheme][version] = 1.0-rc3
projects[kalatheme][subdir] = contrib
projects[kalatheme][patch][1935440] = http://drupal.org/files/kalatheme-illegal-string-offset-1935440-4.patch
libraries[bootstrap][download][type] = get
libraries[bootstrap][download][url] = http://twitter.github.com/bootstrap/assets/bootstrap.zip

; AE Consultation App
projects[ae_consultation][type] = "module"
projects[ae_consultation][download][type] = "git"
projects[ae_consultation][download][url] = "git://github.com/barraponto/ae_consultation.git"
projects[ae_consultation][subdir] = "aeconsulta"

; AE Participants App
projects[ae_participants][type] = "module"
projects[ae_participants][download][type] = "git"
projects[ae_participants][download][url] = "git://github.com/barraponto/ae_participants.git"
projects[ae_participants][subdir] = "aeconsulta"

; Honeypot spam protection
projects[honeypot][version] = 1.14
projects[honeypot][subdir] = contrib

; Localization profile
projects[l10n_install][version] = 1.0-beta24
projects[l10n_update] = 1.x-dev
projects[l10n_update][subdir] = contrib
projects[l10n_update][download][type] = git
projects[l10n_update][download][revision] = fa76206
projects[l10n_update][download][branch] = 7.x-1.x
projects[l10n_client] = 1.2
projects[l10n_client][subdir] = contrib

; Experimental Participants workflow
projects[content_access][version] = 1.2-beta2
projects[content_access][subdir] = contrib
projects[logintoboggan][version] = 1.3
projects[logintoboggan][subdir] = contrib
