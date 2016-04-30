package Chat::Web {

  use Mojo::Base 'Mojolicious';
  use Mojo::EventEmitter; # チャットにはこれ必要！

  use Chat::Model;

  sub startup {
    my $self = shift;

    # event helper
    $self->helper(
      events => sub { state $events = Mojo::EventEmitter->new }
    );
    $self->helper(
      model => sub { state $model = Chat::Model->new }
    );

    my $r = $self->routes;
    $r->namespaces([qw/Chat::Web::Controller/]);
    $r->get('/')->to('root#root');
    $r->websocket('/channel')->to('root#channel');
  }

}

1;
