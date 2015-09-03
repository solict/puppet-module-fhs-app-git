# fhs_app_vcs

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with the module](#setup)
    * [What the module_affects](#what-the-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with the module](#beginning-with-the-module)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Release Notes - Other notable remarks](#release-notes)

## Overview

Puppet module that manages repositories in FHS /app.
Designed for Puppet 3.x and newer in POSIX environments.
Requires solict-fhs_app >= 2.0.0.

## Module Description

The module will implement and manage code repositories in FHS /app, reusing the
configuration defined in solict-fhs_app, including applications.

Git and Mercurial (Hg) repositories are supported.

Consult solict-fhs_app for more information regarding this FHS and
puppetlabs-vcsrepo for information regarding vcsrepo type.

This module has been desgined for Puppet 3.x and newer in POSIX environments.
Requires solict-fhs_app >= 2.0.0.

## Setup

### What fhs_app_vcs affects

* Repositories will be cloned/pulled to the application src directory.
* Permissions and ownership will be applied where applicable.

### Setup Requirements

The following modules are requirements and should be installed.
* puppetlabs-stdlib
* puppetlabs-vcsrepo
* solict-fhs_app >= 2.0.0

### Beginning with the module

When deployed, the directory of the module should be renamed to fhs_app_vcs.

The class fhs_app_vcs must be declared in a manifest or loaded with
hiera_include to be initialized.
All other classes are autoloaded and do not need to be manually initialized.

Parameters can be provided with both methods, for the class fhs_app_vcs.

## Usage

The following parameters are used:

* `defaults`
A hash that defines the default parameters.
It is hard coded into params.pp and can be ignored.
They are used when the other hashes are missing or incomplete.

* `vcs`
A hash that defines the parameters for the vcs class.
These will be used to clone/pull repositories and apply permissions and
ownership to files.
Repositories and locations are customizable.
If no vcs params are provided, no changes will be made.
Multiple vcs repos can be provided.

The file HOWTO.md details sample usage with manifests and hiera.

## Reference

There are 3 classes provided by this module:
- fhs_app, which initializes the module are accepts parameters
- fhs_app::params, which is autoloaded to retrieve parameters
- fhs_app::childs, which is autoloaded to manage the provided repositories

The parameterized vcsrepo and file resources are managed as configured, as
defined for params vcs.

No new resources are provided.

## Limitations

It has been successfully tested in CentOS/RHEL and Debian.
Should be compatible with most of the Linux distributions.

## Development

The source for the module can be found on it's project source page.
Contributions and issues are welcomed.

## Release Notes

This source code comes with absolutely no warranty or liability for damages.

