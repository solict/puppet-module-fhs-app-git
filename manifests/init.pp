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
# * `vcs`
# A hash that defines the parameters for the vcs class.
# These will be used to clone/pull repositories and apply permissions and
# ownership to files.
# Repositories and locations are customizable.
# If no vcs params are provided, no changes will be made.
# Multiple vcs repos can be provided.
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
# @example
#    class { 'fhs_app_vcs':
#      vcs => {(...)},
#    }
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

