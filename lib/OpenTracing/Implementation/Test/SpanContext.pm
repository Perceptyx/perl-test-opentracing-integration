package OpenTracing::Implementation::Test::SpanContext;
use Moo;
use Types::Standard qw/Int/;
use Bytes::Random::Secure qw/random_bytes_hex/;

with 'OpenTracing::Role::SpanContext';

has '+span_id' => (
    default => sub { random_bytes_hex(7) },
);

has '+trace_id' => (
    default => sub { random_bytes_hex(7) },
);

has level => (
    is      => 'ro',
    isa     => Int,
    default => sub { 0 },
);

sub with_level { $_[0]->clone_with( level => $_[1] ) }

sub with_next_level { $_[0]->with_level($_[0]->level + 1) }

1;
