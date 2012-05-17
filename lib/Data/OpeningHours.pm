use strict;
use warnings;
package Data::OpeningHours;

use parent 'Exporter';

our $VERSION = '1.0.0';

our @EXPORT_OK = qw/is_open/;

sub is_open {
    my ($calendar, $now) = @_;
    return $calendar->is_open($now);
}

1;

=head1 NAME

Data::OpeningHours - Is a shop is open or closed at this moment?

=head1 SYNOPSYS

    use DateTime;
    use Data::OpeningHours 'is_open';
    use Data::OpeningHours::Calendar;

    my $cal = Data::OpeningHours::Calendar->new();
    $cal->set_week_day(1, [['13:00','18:00']]); # monday
    $cal->set_week_day(2, [['09:00','18:00']]);
    $cal->set_week_day(3, [['09:00','18:00']]);
    $cal->set_week_day(4, [['09:00','18:00']]);
    $cal->set_week_day(5, [['09:00','21:00']]);
    $cal->set_week_day(6, [['09:00','17:00']]);
    $cal->set_week_day(7, []);
    $cal->set_special_day('2012-01-01', []);
    is_open($cal, DateTime->now());

=head1 DESCRIPTION

Data::OpeningHours helps you create a widget that shows when a shop is open or
closed.

=cut

