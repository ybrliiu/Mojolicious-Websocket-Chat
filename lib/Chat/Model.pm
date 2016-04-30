package Chat::Model {

  use Mouse;
  use Chat;

  use Chat::DB;

  my $CONFIG = Chat::load_config('etc/db.conf');
  has 'DB' => (is => 'rw', lazy => 1, builder => '_build_DB');
  
  sub _build_DB {
    return Chat::DB->new(%$CONFIG);
  }
  
  sub get {
    my ($self, $num) = @_;
    my @data = reverse $self->DB->search('chat_record')->all;
    return \@data;
  }

  sub create {
    my ($self, $name, $message) = @_;
    $self->DB->insert('chat_record', {
      id => $self->search_max_id() + 1,
      name => $name,
      message => $message,
    });
  }

  sub search_max_id {
    my ($self) = @_;
    my $itr = $self->DB->search('chat_record');
    my $max = 0;
    while (my $row = $itr->next) {
      $max = $row->id if $row->id > $max;
    }
    return $max;
  }

  __PACKAGE__->meta->make_immutable();
}

1;
