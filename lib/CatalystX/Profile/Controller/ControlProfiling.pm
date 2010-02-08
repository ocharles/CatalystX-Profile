# ABSTRACT: Control profiling within your application
package CatalystX::Profile::Controller::ControlProfiling;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

use Devel::NYTProf;

sub stop_profiling : Local {
    my ($self, $c) = @_;
    DB::finish_profile();
    $c->log->debug('Profiling has now been disabled');
    $c->body('Profiling finished');
}

1;

=head1 DESCRIPTIONS

Some actions you can use to control profiling

=head1 ACTIONS

=head2 stop_profiling

Stop and finish profiling, and write all the output. This can be a bit
slow while the profiling data is written, but that's normal.

=cut
