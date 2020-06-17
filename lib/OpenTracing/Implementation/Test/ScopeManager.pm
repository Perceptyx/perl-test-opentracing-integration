package OpenTracing::Implementation::Test::ScopeManager;
use Moo;
use OpenTracing::Implementation::Test::Scope;

with 'OpenTracing::Role::ScopeManager';

has '+active_scope' => (
    clearer => 'final_scope',
);

sub build_scope {
    my ($self, %options) = @_;
    my $span                 = $options{span};
    my $finish_span_on_close = $options{finish_span_on_close};

    my $current_scope = $self->get_active_scope;
    my $restore_scope =
      $current_scope
      ? sub { $self->set_active_scope($current_scope) }
      : sub { $self->final_scope() };

    my $scope = OpenTracing::Implementation::Test::Scope->new(
        span                 => $span,
        finish_span_on_close => $finish_span_on_close,
        on_close             => $restore_scope,
    );

    return $scope
}

1;
