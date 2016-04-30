package Chat::Web::Controller::Root {

  use Mojo::Base 'Mojolicious::Controller';

  sub root {
    my $self = shift;
    $self->stash(message => $self->model->get());
    $self->render();
  }

  sub channel {
    my $self = shift;

    # インアクティビティタイムアウト, Default::Helperでできる
    $self->inactivity_timeout(300);

    # JSONオブジェクトをWebSocketを通して受ける
    $self->on(json => sub {
      my ($c, $json) = @_; # self, jsonオブジェクト
      $json->{message} =~ s/\n/<br>/g;
      $c->model->create($json->{name}, $json->{message});
      $c->events->emit(chat => $json); # イベントを発行
    });

    # jsonをブラウザ側に送る
    my $cb = $self->events->on( # イベントを読む
      chat => sub {
        my ($event, $json) = @_; # Mojo::EventEmitterオブジェクトのインスタンス, 上で受け取ったjsonオブジェクト
        $self->send({json => $json}); # jsonを送信
      }
    );
    
    # トランザクション終了後の処理(ブラウザ側の接続が切れた時)
    $self->on(finish => sub {
      my ($self) = @_;
      $self->events->unsubscribe(chat => $cb); # イベントを読むのをやめる
    });
  }

}

1;
