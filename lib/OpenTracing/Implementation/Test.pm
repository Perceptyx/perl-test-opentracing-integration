package OpenTracing::Implementation::Test;
use Moo;
use aliased 'OpenTracing::Implementation::Test::Tracer';

with 'OpenTracing::Implementation::Interface::Bootstrap';

sub bootstrap_tracer {
    my $class = shift;
    return Tracer->new(@_);
}

1;
