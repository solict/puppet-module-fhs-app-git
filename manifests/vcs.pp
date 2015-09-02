# Class: fhs_app_vcs::vcs
# ===========================
#
# ...
#
# Authors
# -------
#
# Luís Pedro Algarvio <lp.algarvio@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2015 SOL-ICT.
#
class fhs_app_vcs::vcs (

  # Import hashes from parent module
  $defaults_hsh = merge($fhs_app::defaults, $fhs_app_vcs::defaults),
  $mother_hsh   = $fhs_app::mother,
  $childs_hsh   = $fhs_app::childs,

  # Store hashes to simplify variable usage
  $vcses_hsh    = $fhs_app_vcs::vcs,

) inherits fhs_app_vcs {

  #
  # Validate and iterate through vcs hash
  #
  if is_hash($vcses_hsh) {
    keys($vcses_hsh).each |String $vcs_str| {

      # Store hashes to simplify variable usage
      $def_mother_hsh = $defaults_hsh[mother]
      $def_childs_hsh = $defaults_hsh[childs]
      $child_hsh      = $childs_hsh[$vcs_str]
      $def_vcs_hsh    = $defaults_hsh[vcs]
      $vcs_hsh        = $vcses_hsh[$vcs_str]
      $child_mrg_hsh  = merge($child_hsh, $vcs_hsh)

      #
      # Validate if vcs is enabled
      #
      if has_key($child_mrg_hsh, 'manage') {
        if $child_mrg_hsh[manage]==true {

          # Validate shared parameters
          if !has_key($mother_hsh[home], 'path') and !has_key($def_mother_hsh[home], 'path') {
            fail('Invalid fhs_app::mother:home:path and fhs_app::defaults:mother:home:path hash')
          } elsif has_key($mother_hsh[home], 'path') {
            $mother_home_path = $mother_hsh[home][path]
          } elsif !has_key($mother_hsh[home], 'path') and has_key($def_mother_hsh[home], 'path') {
            $mother_home_path = $def_mother_hsh[home][path]
          }
          if !has_key($child_hsh[home], 'path') and !has_key($def_childs_hsh[home], 'path') {
            $child_home_path = $vcs_str
          } elsif has_key($child_hsh[home], 'path') {
            $child_home_path = $child_hsh[home][path]
          } elsif !has_key($child_hsh[home], 'path') and has_key($def_childs_hsh[home], 'path') {
            $child_home_path = $def_childs_hsh[home][path]
          }

          # Validate and iterate through vcs repos hash
          if has_key($child_mrg_hsh, 'repos') {
            keys($child_mrg_hsh[repos]).each |String $repo_str| {

              # Store hashes to simplify variable usage
              $def_repo_hsh = $def_vcs_hsh[repos]
              $repo_hsh     = $child_mrg_hsh[repos][$repo_str]

              #
              # Validate if vcs repo is enabled
              #
              if has_key($repo_hsh, 'manage') {
                if $repo_hsh[manage]==true {

                  #
                  # Validate if child src dir is enabled
                  #
                  if has_key($child_mrg_hsh, 'dirs') {
                    if has_key($child_mrg_hsh[dirs], 'src') {
                      if has_key($child_mrg_hsh[dirs][src], 'manage') {
                        if $child_mrg_hsh[dirs][src][manage]==true {

                          # Store hashes to simplify variable usage
                          $def_childs_src_hsh = $def_childs_hsh[dirs][src]
                          $child_src_hsh      = $child_mrg_hsh[dirs][src]

                          # Validate shared parameters
                          if !has_key($child_src_hsh, 'path') and !has_key($def_childs_src_hsh, 'path') {
                            $child_src_path = 'src'
                          } elsif has_key($child_src_hsh, 'path') {
                            $child_src_path = $child_src_hsh[path]
                          } elsif !has_key($child_src_hsh, 'path') and has_key($def_childs_src_hsh, 'path') {
                            $child_src_path = $def_childs_src_hsh[path]
                          }
                          if has_key($repo_hsh, 'path') {
                            $repo_path = $repo_hsh[path]
                          } else {
                            $repo_path = $repo_str
                          }

                          # Validate specific parameters
                          if !has_key($repo_hsh, 'ensure') and !has_key($def_repo_hsh, 'ensure') {
                            fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:ensure and fhs_app_vcs::defaults:vcs:repos:ensure hash")
                          }
                          if !has_key($repo_hsh, 'provider') {
                            fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:provider hash")
                          } else {
                            if $repo_hsh[provider]!='git' and $repo_hsh[provider]!='hg' {
                              fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:provider hash")
                            }
                          }
                          if !has_key($repo_hsh, 'source') {
                            fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:source hash")
                          }
                          if !has_key($repo_hsh, 'revision') and !has_key($def_repo_hsh, 'revision') {
                            fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:revision and fhs_app_vcs::defaults:vcs:repos:revision hash")
                          }
                          if !has_key($repo_hsh, 'submodules') and !has_key($def_repo_hsh, 'submodules') {
                            fail("Invalid fhs_app_vcs::vcs:${vcs_str}:repos:${repo_str}:submodules and fhs_app_vcs::defaults:vcs:repos:submodules hash")
                          }
                          # Clone repo into directory
                          vcsrepo { "fhs_app_vcs-child-${vcs_str}_${repo_str}_repo":
                            ensure     => inline_template("<% if scope.function_has_key([@repo_hsh, 'ensure']) %>${repo_hsh[ensure]}<% else %>${def_repo_hsh[ensure]}<% end %>"),
                            path       => "${mother_home_path}/${child_home_path}/${child_src_path}/${repo_path}",
                            force      => false,
                            provider   => $repo_hsh[provider],
                            source     => $repo_hsh[source],
                            revision   => inline_template("<% if scope.function_has_key([@repo_hsh, 'revision']) %>${repo_hsh[revision]}<% else %>${def_repo_hsh[revision]}<% end %>"),
                            submodules => inline_template("<% if scope.function_has_key([@repo_hsh, 'submodules']) %>${repo_hsh[submodules]}<% else %>${def_repo_hsh[submodules]}<% end %>"),
                            owner      => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'name']) %>${child_hsh[user][name]}<% else %>${child_str}<% end %>"),
                            group      => inline_template("<% if scope.function_has_key([@child_hsh['group'], 'name']) %>${child_hsh[group][name]}<% else %>${child_str}<% end %>"),
                          }

                          # Validate specific parameters
                          if !has_key($child_src_hsh, 'mode') and !has_key($def_childs_src_hsh, 'mode') {
                            fail("Invalid fhs_app::childs:${child_str}:dirs:src:mode and fhs_app::defaults:childs:dirs:src:mode hash")
                          }
                          # Create repo directory
                          file { "fhs_app_vcs-child-${vcs_str}_${repo_str}_dir":
                            ensure  => directory,
                            path    => "${mother_home_path}/${child_home_path}/${child_src_path}/${repo_path}",
                            backup  => false,
                            force   => false,
                            purge   => false,
                            recurse => true,
                            owner   => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'name']) %>${child_hsh[user][name]}<% else %>${child_str}<% end %>"),
                            group   => inline_template("<% if scope.function_has_key([@child_hsh['group'], 'name']) %>${child_hsh[group][name]}<% else %>${child_str}<% end %>"),
                            mode    => inline_template("<% if scope.function_has_key([@child_src_hsh, 'mode']) %>${child_src_hsh[mode]}<% else %>${def_childs_src_hsh[mode]}<% end %>"),
                          }

                        }
                      }
                    }
                  }

                }
              }

            }
          }

        }
      }

    }
  } else {
    fail("Invalid fhs_app_vcs::childs:${vcs_str} hash")
  }

}

