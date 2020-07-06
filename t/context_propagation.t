use Test::Most;
use Test::OpenTracing::Integration;
use OpenTracing::Implementation qw/Test/;
use OpenTracing::GlobalTracer;

my $root_scope = $TRACER->start_active_span('root_span');
my $root_span  = $root_scope->get_span();
check_context($root_span->get_context(),
    'extracted context is the same as injected');

my %active;
$TRACER->inject_context(\%active);
cmp_context(
    $TRACER->extract_context(\%active),
    $TRACER->get_active_span->get_context,
    'active context injected by default'
);

my $child = $TRACER->start_active_span('child1');
check_context($child->get_span->get_context(), 'incremented level propagated');
$child->close();

my $with_item = $TRACER->start_active_span('child2',
    child_of => $root_span->get_context->with_context_item(12));
my $item_span = $with_item->get_span();
check_context($with_item->get_span->get_context(), 'context item propagated');
$with_item->close();

my $with_baggage = $TRACER->start_active_span('baggage');
my $baggage_span = $with_baggage->get_span();
$baggage_span->add_baggage_items(a => 1, b => 2);
check_context($baggage_span->get_context(), 'baggage_items propagated');
$with_baggage->close();

$root_scope->close();

done_testing();

sub check_context {
    my ($context, $name) = @_;

    my %carrier;
    $TRACER->inject_context(\%carrier, $context);
    my $extracted = $TRACER->extract_context(\%carrier);
    
    return cmp_context($extracted, $context, $name);
}

sub cmp_context {
    my ($got, $exp, $name) = @_;

    foreach my $context ($got, $exp) {
        $context = {
            span_id       => $context->span_id,
            trace_id      => $context->trace_id,
            level         => $context->level,
            context_item  => $context->context_item,
            baggage_items => { $context->get_baggage_items },
        };
    }
    is_deeply($got, $exp, $name) or explain $got;
}
