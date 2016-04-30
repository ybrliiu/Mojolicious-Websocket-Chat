package Chat::DB::Schema {

  use feature ':5.22';
  use utf8;
  use Teng::Schema::Declare;
  
  table {
    name 'chat_record';
    pk 'Id';
    columns qw/id name message/;
  };
}

1;

