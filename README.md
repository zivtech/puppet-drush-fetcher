# Puppet Drush Fetcher

Installs [fetcher](https://drupal.org/project/fetcher) and optionally installs
its dependencies and fetcher_services.

## Basic usage:

```` puppet
include drush_fetcher
````

## Advanced usage:

``` puppet 
class { 'drush_fetcher':
  # Installs fetcher at this specific git commit.
  git_ref => 'd88cb50421',
}
```
