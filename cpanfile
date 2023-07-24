requires 'aliased';
requires 'Bytes::Random::Secure';
requires 'Carp';
requires 'Moo';
requires 'namespace::clean';
requires 'Tree';
requires 'OpenTracing::Implementation::Interface::Bootstrap';
requires 'OpenTracing::GlobalTracer', '0.04';
requires 'OpenTracing::Role', 'v0.84.0';
requires 'Types::Standard';
requires 'Test::Builder';
requires 'Test::Deep';
requires 'PerlX::Maybe';
requires 'Scalar::Util';

on 'test' => sub {
    requires 'HTTP::Headers';
    requires 'Test::OpenTracing::Interface', 'v0.23.0';
    requires 'Moo';
    requires 'Carp';
    requires 'Test::Most';
    requires 'Test::Time::HiRes';
    requires 'List::Util'
};

on 'develop' => sub {
    requires 'ExtUtils::MakeMaker::CPANfile';
};
