# Class: fhs_app_vcs::childs
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
class fhs_app_vcs::childs (

  # Import and merge hashes
  $defaults = merge($fhs_app::defaults, $fhs_app_vcs::defaults),
  $mother = merge($fhs_app::mother, $fhs_app_vcs::mother),
  $childs = merge($fhs_app::childs, $fhs_app_vcs::childs),

) inherits fhs_app_vcs {

  #
  # Validate and iterate through childs hash
  #
  if is_hash($childs) {
    keys($childs).each |String $child| {

      notify { "child: ${child}": }

      #
      # Validate if child is enabled
      #
      if has_key($childs[$child], 'manage') {
        if $childs[$child][manage]==true {

          # Validate and iterate through childs repos hash
          if has_key($childs[$child], 'repos') {
            keys($childs[$child][repos]).each |String $repo| {

              #
              # Validate if child repo is enabled
              #
              if has_key($childs[$child][repos][$repo], 'manage') {
                if $childs[$child][repos][$repo][manage]==true {

                  notify { "repo: ${child}/${repo}": }

                }
              }

            }
          }

        }
      }

    }
  } else {
    fail("Invalid fhs_app_vcs::childs:${child} hash")
  }

}

