requires 'aliased';
requires 'Bytes::Random::Secure';
requires 'Moo';
requires 'namespace::clean';
requires 'Tree';
requires 'OpenTracing::Implementation::Interface::Bootstrap';
requires 'OpenTracing::GlobalTracer', '0.04';
requires 'OpenTracing::Role', 'v0.83.0';
requires 'Types::Standard';
requires 'OpenTracing::Implementation::NoOp';

on 'test' => sub {
    requires 'Test::OpenTracing::Interface', 'v0.23.0';
    requires 'Test::Time::HiRes';
};

on 'develop' => sub {
    requires 'ExtUtils::MakeMaker::CPANfile';
};
