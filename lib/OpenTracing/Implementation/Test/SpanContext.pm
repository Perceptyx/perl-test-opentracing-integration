package OpenTracing::Implementation::Test::SpanContext;

our $VERSION = 'v0.100.1';

use Moo;
use Types::Standard qw/Int/;
use Bytes::Random::Secure qw/random_string_from/;

with 'OpenTracing::Role::SpanContext';

has '+span_id' => (
    default => \&_random_id,
);

has '+trace_id' => (
    default => \&_random_id,
);

has level => (
    is      => 'ro',
    isa     => Int,
    default => sub { 0 },
);

sub with_level { $_[0]->clone_with( level => $_[1] ) }

sub with_next_level { $_[0]->with_level($_[0]->level +1) }

sub _random_id {
    random_string_from '0123456789abcdef', 7
}

1;



=head1 NAME

OpenTracing::Implementation::Test::SpanContext - OpenTracing Test for SpanContext



=head1 AUTHOR

Szymon Nieznanski <snieznanski@perceptyx.com>



=head1 COPYRIGHT AND LICENSE

'Test::OpenTracing::Integration'
is Copyright (C) 2019 .. 2020, Perceptyx Inc

This library is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0.

This package is distributed in the hope that it will be useful, but it is
provided "as is" and without any express or implied warranties.

For details, see the full text of the license in the file LICENSE.


=cut
