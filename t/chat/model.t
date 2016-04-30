use Chat;
use Test::More;

my $obj;
my $class = 'Chat::Model';

use_ok $class;

subtest 'new' => sub {
  $obj = $class->new();
  isa_ok($obj, $class);
};

subtest 'search_max_id' => sub {
  diag 'max id is ', $obj->search_max_id();
  ok 1;
};

subtest 'create' => sub {
  $obj->create(tester => 'testing message...');
  ok 1;
};

subtest 'get' => sub {
  diag explain($obj->get);
  ok 1;
};

done_testing;
