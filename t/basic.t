use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Chat::Web');
$t->get_ok('/')->status_is(200)->content_like(qr/Name/i);

done_testing();
