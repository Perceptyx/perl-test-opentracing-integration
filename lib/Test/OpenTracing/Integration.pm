package Test::OpenTracing::Integration;

our $VERSION = 'v0.1.0';

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
    croak 'Not a test implementation' if !$tracer->can('cmp_easy');
    return $tracer->cmp_easy(@_);
}

sub global_tracer_cmp_deeply {
    my $tracer = OpenTracing::GlobalTracer->get_global_tracer;
    croak 'Not a test implementation' if !$tracer->can('cmp_deeply');
    return $tracer->cmp_deeply(@_);
}

sub reset_spans {
    my $tracer = OpenTracing::GlobalTracer->get_global_tracer;
    croak 'Not a test implementation' if !$tracer->can('clear_spans');
    return $tracer->clear_spans();
}

1;
__END__
=pod

=head1 NAME

Test::OpenTracing::Integration - utilities for writing tests with OpenTracing::Implementation::Test

=head1 SYNOPSIS

  package MyApp {
     use OpenTracing::GlobalTracer qw/$TRACER/;

     sub something {
       my $scope = $TRACER->start_active_span('some-work');

       $TRACER->start_span('more-work')->finish;

       $scope->close
     }
  }


  use OpenTracing::Implementation qw/Test/;
  use Test::OpenTracing::Integration;

  use MyApp;

  MyApp->something();

  global_tracer_cmp_easy($tracer, [
      { operation_name => 'some-work', level => 0 },
      { operation_name => 'more-work', level => 1 },
    ],
    'child span created'
  );


=head1 FUNCTIONS

All of these functions require the current global tracer to be an instance
of L<OpenTracing::Implementation::Test::Tracer>. All are exported by default.

=head1 global_tracer_cmp_deeply($expected, $test_name)

Runs a L<cmp_deeply> on the current global tracer.

=head1 global_tracer_cmp_easy($expected, $test_name)

Runs a L<cmp_easy> on the current global tracer.

=head1 reset_spans()

Removes all saved spans from the current global tracer.
Useful to start fresh before new test cases.

=cut
