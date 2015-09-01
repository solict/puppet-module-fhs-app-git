# Class: fhs_app_vcs
# ===========================
#
# Initializes the module, loading the necessary dependencies and classes.
#
# Parameters
# ----------
#
# The following parameters are used:
#
# ...
#
# More information can be found on HOWTO.md.
#
# Variables
# ----------
#
# There are no variables being used.
#
# Examples
# --------
#
# ...
#
# More information can be found on HOWTO.md.
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
class fhs_app_vcs (

  # Hashes
  $defaults                  = $fhs_app_vcs::params::defaults,
  $childs                    = $fhs_app_vcs::params::childs,

) inherits fhs_app_vcs::params {

  # Include dependencies
  include stdlib

  # Autoload module classes
  anchor { 'fhs_app_vcs::begin': } ->
    # Load Childs class
    class { '::fhs_app_vcs::childs': } ->
  anchor { 'fhs_app_vcs::end': }

}

