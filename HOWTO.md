The module can be configured with either declarations in a manifest or parameters in hiera.
The defaults hash can be safely ignored.

### Manifest example

```puppet
#
# App
#
class { '::fhs_app_vcs':
  defaults => {
    vcs => {
      repos => {
        ensure         => 'latest',              # optional, string
        revision       => 'master',              # optional, string
        submodules     => true,                  # optional, boolean
      },
    },
  },
  vcs => {
    user1 => {
      manage           => true,
      repos => {
        repo1 => {
          manage       => true,                  # required, boolean
          path         => 'repo1',               # optional, string
          provider     => 'git',                 # required, string
          source       => 'http://example.com/repo1', # required, string
          revision     => 'master',              # optional, string
          ensure       => 'present',             # optional, string
          submodules   => true,                  # optional, boolean
        },
        repo2 => {
          manage       => true,                  # required, boolean
          path         => 'repo2',               # optional, string
          provider     => 'git',                 # required, string
          source       => 'http://example.com/repo2', # required, string
          revision     => 'devel',               # optional, string
          ensure       => 'latest',              # optional, string
          submodules   => false,                 # optional, boolean
        },
      },
    },
    user2 => {
      manage           => true,
      repos => {
        repo3 => {
          manage       => true,                  # required, boolean
          path         => 'repo3',               # optional, string
          provider     => 'hg',                  # required, string
          source       => 'http://example.com/repo3', # required, string
          revision     => 'feature-xyz',               # optional, string
          ensure       => 'latest',              # optional, string
          submodules   => false,                 # optional, boolean
        },
      },
    },
  },
}

```


### Hiera example

```yaml
---
#
# App
#
fhs_app_vcs::defaults:
  vcs:
    repos:
      ensure:          latest                    # optional, string
      revision:        master                    # optional, string
      submodules:      true                      # optional, boolean
fhs_app_vcs::vcs:
  user1:
    manage:            true
    repos:
      repo1:
        manage:        true                      # required, boolean
        path:          repo1                     # optional, string
        provider:      git                       # required, string
        source:        http://example.com/repo1  # required, string
        revision:      master                    # optional, string
        ensure:        present                   # optional, string
        submodules:    true                      # optional, boolean
      repo2:
        manage:        true                      # required, boolean
        path:          repo2                     # optional, string
        provider:      git                       # required, string
        source:        http://example.com/repo2  # required, string
        revision:      devel                     # optional, string
        ensure:        latest                    # optional, string
        submodules:    false                     # optional, boolean
  user2:
    manage:            true
    repos:
      repo3:
        manage:        true                      # optional, boolean
        path:          repo3                     # optional, string
        provider:      hg                        # required, string
        source:        http://example.com/repo3  # required, string
        revision:      feature-xyz               # optional, string
        ensure:        latest                    # optional, string
        submodules:    false                     # optional, boolean

```
Additionally, for hiera, the classes lookup must be initialized in the main manifest:
```
hiera_include('classes') 
```

