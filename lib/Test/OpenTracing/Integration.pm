package Test::OpenTracing::Integration;

our $VERSION = 'v0.102.3';

use strict;
use warnings;
use parent 'Exporter';
use Carp qw/croak/;
use Test::Builder;
use Test::Deep qw/bag superhashof cmp_details deep_diag/;
use OpenTracing::GlobalTracer;

our @EXPORT = qw(
    reset_spans
    global_tracer_cmp_easy
    global_tracer_cmp_deeply
);

sub global_tracer_cmp_easy {
    my $tracer = OpenTracing::GlobalTracer->get_global_tracer;
    my $next = $tracer->can('cmp_easy')
        or croak 'Not a test implementation';
    unshift @_, $tracer;
    goto $next;
}

sub global_tracer_cmp_deeply {
    my $tracer = OpenTracing::GlobalTracer->get_global_tracer;
    my $next = $tracer->can('cmp_deeply')
        or croak 'Not a test implementation';
    unshift @_, $tracer;
    goto $next;
}


sub reset_spans {
    my $tracer = OpenTracing::GlobalTracer->get_global_tracer;
    croak 'Not a test implementation' if !$tracer->can('clear_spans');
    return $tracer->clear_spans();
}

1;
