The module can be configured with either declarations in a manifest or parameters in hiera.

### Manifest example

```puppet
#
# App
#
class { '::fhs_app_vcs':
  defaults => {
  },
  mother => {
  },
  childs => {
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
fhs_app_vcs::mother:
fhs_app_vcs::childs:


```
Additionally, for hiera, the classes lookup must be initialized in the main manifest:
```
hiera_include('classes') 
```

