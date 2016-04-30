package Chat::DB::Row::ChatRecord {

  use v5.22;
  use warnings;
  use utf8;
  use parent 'Teng::Row';

  sub say_name {
    my $self = shift;
    say $self->name;
  }

}
1;
