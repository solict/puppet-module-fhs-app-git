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
  $defaults = $fhs_app_vcs::params::defaults,
  $vcs      = $fhs_app_vcs::params::vcs,

) inherits fhs_app_vcs::params {

  # Include dependencies
  include stdlib
  include fhs_app

  # Autoload module classes
  anchor { 'fhs_app_vcs::begin': } ->
    # Load VCS class
    class { '::fhs_app_vcs::vcs': } ->
  anchor { 'fhs_app_vcs::end': }

}

