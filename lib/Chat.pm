package Chat 0.01 {

  use strict;
  use warnings;
  use utf8;
  use feature ':5.18';
  
  use Cwd 'getcwd';
  use Config::PL;
  
  # インポート
  sub import {
    my ($class) = @_;
    $_->import for(qw/strict warnings/);
    utf8->import;
    feature->import(':5.18');
  }

  # project_dir
  sub project_dir {
    state $dir;
    return $dir if $dir;
    $dir = getcwd() . '/';
    $dir;
  }
  
  # load configfile
  sub load_config {
    my ($filepath) = @_;
    my $config = config_do(project_dir() . $filepath);
    return $config;
  }

}

1;

