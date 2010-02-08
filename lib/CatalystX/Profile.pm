# ABSTRACT: Profile your Catalyst application with Devel::NYTProf
package CatalystX::Profile;
use Moose::Role;
use namespace::autoclean;

use CatalystX::InjectComponent;
use Devel::NYTProf;

after 'setup_finalize' => sub {
    my $self = shift;
    $self->log->debug('Profiling is active');
    DB::enable_profile();
};

after 'setup_components' => sub {
    my $class = shift;
    CatalystX::InjectComponent->inject(
        into => $class,
        component => 'CatalystX::Profile::Controller::ControlProfiling',
        as => 'Controller::Profile'
    );
};

1;

=head1 SYNOPSIS

    # In MyApp.pm
    use Catalyst qw( +CatalystX::Profile );

    export NYTPROF=start=no
    perl -d:NYTProf script/myapp_server.pl

    ... click around on your website ...

    Finish profiling: /profile/stop_profiling

=head1 DESCRIPTION

This (really basic for now) plugin adds support for profiling your
Catalyst application, without profiling all the crap that happens
during setup. This noise can make finding the real profiling stuff
trickier, so profiling is disabled while this happens.

=head1 BUGS, WARNINGS, POTENTIAL HEALTH HAZARDS

This module is really new - but it does do what it says on the tin so
far. But I really need some feedback! Please submit all feature
suggestions either on here via RT, or just poke me on irc.perl.org
(I'm aCiD2).

=cut
