class drush_fetcher (
  $drush_command_path = '/usr/share/drush/commands',
  $git_ref = '7.x-1.x',
  $manage_dependencies = true,
  $manage_fetcher_services = true,
  $fetcher_services_git_ref = '7.x-1.x'
) {

  require drush
  include wget

  vcsrepo { "${drush_command_path}/drush_fetcher":
    require  => File["/usr/share/drush", "/usr/share/drush/commands"],
    ensure   => present,
    provider => git,
    source   => "http://git.drupal.org/project/fetcher.git",
    revision => $git_ref,
  }

  if ($manage_dependencies) {

    require php::composer

    exec { "/usr/bin/php /usr/local/bin/composer install --no-dev":
      cwd         => "${drush_command_path}/drush_fetcher",
      creates     => "${drush_command_path}/drush_fetcher/vendor",
      environment => "HOME=/root/",
      require     => [
        Class['php::cli'],
        Vcsrepo["${drush_command_path}/drush_fetcher"],
      ],
      subscribe   => "${drush_command_path}/drush_fetcher",
    }

  }

  if ($manage_fetcher_services) {
    vcsrepo { "${drush_command_path}/fetcher_services":
      require  => File["/usr/share/drush", "/usr/share/drush/commands"],
      ensure   => present,
      provider => git,
      source   => "http://git.drupal.org/project/fetcher_services.git",
      revision => $fetcher_services_git_ref,
    }
  }

}