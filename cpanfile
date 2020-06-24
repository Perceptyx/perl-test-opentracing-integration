requires 'aliased';
requires 'Bytes::Random::Secure';
requires 'Moo';
requires 'namespace::clean';
requires 'Tree';
requires 'OpenTracing::GlobalTracer', '0.04';
requires 'OpenTracing::Role', 'v0.82.0';
requires 'Types::Standard';
recommends 'Open Tracing::Implementation::NoOp';

on 'test' => sub {
    requires 'Test::OpenTracing::Interface', 'v0.23.0';
};

on 'develop' => sub {
    requires 'ExtUtils::MakeMaker::CPANfile';
};
